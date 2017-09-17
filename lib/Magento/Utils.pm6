use v6;

unit module Magento::Utils;

subset StrInt of Any where Str|Int;

proto sub search-criteria-to-query-string(|) is export {*}
multi sub search-criteria-to-query-string(
    StrInt $data,
    Str    $parent,
    Int    :$filtergroup_i,
    Int    :$filters_i
    --> Str
) {
    "{$parent}]={$data}";
}

multi sub search-criteria-to-query-string(
    Pair $data,
    Str  $parent,
    Int  :$filtergroup_i,
    Int  :$filters_i
    --> Str
) {
    "[{$data.key}]={$data.value}"; 
}

multi sub search-criteria-to-query-string(
    Iterable $data,
    Str      $parent,
    Int      :$filtergroup_i is copy,
    Int      :$filters_i is copy
    --> Str
) {
    (map -> $v {
        my $segment = search-criteria-to-query-string $v, $parent, :$filtergroup_i, :$filters_i;
        ++$filters_i;
        # Only increment when we progress to the next filterGroup
        ++$filtergroup_i when $v.values[0][0].keys.any ~~ 'field'|'value'|'condition_type';
        $segment;
    }, @$data).join('&');
}

multi sub search-criteria-to-query-string(
    Hash $data,
    Str  $parent,
    Int  :$filtergroup_i is copy,
    Int  :$filters_i is copy
    --> Str
) {

    (map -> $k, $v {
        my $prefix = do given $parent {
            when 'filters' {
                "searchCriteria[filterGroups][$filtergroup_i][filters][$filters_i][";
            }
            when 'searchCriteria' {
                $v ~~ Array ?? "" !! "{$parent}[";
            }
            when 'filterGroups' {
                $filters_i = 0;
                ''
            }
            default {
                "{$parent}][$filters_i][";
            }
        }
        $prefix ~ search-criteria-to-query-string($v, $k, :$filtergroup_i, :$filters_i);
    }, kv $data).join('&');
}

multi sub search-criteria-to-query-string(
    Hash $data,
    Int  $filtergroup_i = 0,
    Int  $filters_i     = 0
    --> Str
) {
    (map -> $k, $v {
        search-criteria-to-query-string($v, $k, :$filtergroup_i, :$filters_i);
    }, kv $data).head;
}

multi sub search-criteria-to-query-string(
    Hash $data where $data ~~ %()
) {
    'searchCriteria';
}

sub tokenize($str) is export {
    (m/ [\S* \s* '/V1/'] <(\S*)> / given $str)
    ==> split('/')
    ==> grep({$_ !~~ /^':'/ })
    ==> join('')
}

