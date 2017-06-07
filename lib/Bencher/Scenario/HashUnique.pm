package Bencher::Scenario::HashUnique;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our $scenario = {
    summary => 'Benchmark Hash::Unique',
    modules => {
        'Hash::Unique' => { version=>"0.06" },
    },
    participants => [
        {
            name => 'Hash::Unique',
            module => 'Hash::Unique',
            code_template => '[ Hash::Unique->get_unique_hash(<array>, <key>) ]',
        },
        {
            name => 'ad-hoc',
            code_template => 'my @res; my %seen; for (@{ <array> }) { push @res, $_ unless $seen{ $_->{ <key> } }++ }; \@res',
        },
    ],
    datasets => [
        {
            name=>'2elems-1key',
            args=>{
                array=>[
                    {a=>1},
                    {a=>1},
                ],
                key => 'a',
            },
            result=>[
                {a=>1},
            ],
        },
        {
            name=>'10elems-3keys',
            args=>{
                array=>[
                    {a=>1, b=>1, c=>1}, #0
                    {a=>1, b=>1, c=>1}, #1
                    {a=>1, b=>1, c=>2}, #2
                    {a=>1, b=>2, c=>1}, #3
                    {a=>1, b=>1, c=>1}, #4
                    {a=>1, b=>2, c=>1}, #5
                    {a=>1, b=>1, c=>3}, #6
                    {a=>1, b=>1, c=>4}, #7
                    {a=>1, b=>2, c=>1}, #8
                    {a=>2, b=>1, c=>2}, #9
                ],
                key => 'c',
            },
            result=>[
                {a=>1, b=>1, c=>1}, #0
                {a=>1, b=>1, c=>2}, #2
                {a=>1, b=>1, c=>3}, #6
                {a=>1, b=>1, c=>4}, #7
            ],
        },
    ],
};

1;
# ABSTRACT:
