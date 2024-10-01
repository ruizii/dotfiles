<?php

$finder = (new PhpCsFixer\Finder())
    ->in(__DIR__)
;

return (new PhpCsFixer\Config())
    ->setRules([
        '@PSR12' => true,
        'lowercase_keywords' => false,
        'elseif' => false,
        'braces_position' => ['functions_opening_brace' => 'same_line']
    ])
    ->setFinder($finder)
;
