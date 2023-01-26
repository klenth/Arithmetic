grammar Arithmetic;

input
    : expr EOF
    ;

// ANTLR: rules that are earlier have higher precedence;
//        prefers left-associativity when the same rule/operator
expr
    : NUMBER
    | ('+' | '-') expr          // unary -
    | expr ('*' | '/') expr
    | expr ('+' | '-') expr
    | '(' expr ')'
    ;

NUMBER
    : [0-9]+
    | [0-9]+ '.' [0-9]+
    ;

WHITESPACE
    : [ \r\n\t]+    -> skip
    ;