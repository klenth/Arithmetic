grammar Arithmetic;

@parser::header {
// This code will be included at the top of the parser .java file
import java.util.List;
}

input
returns [double x]
    : expr EOF {
        $x = $expr.x;
    }
    ;

// Adding { } after a parser rule alternative creates a "semantic action":
// code that is executed by the parser when it matches that alternative.

// ANTLR: rules that are earlier have higher precedence;
//        prefers left-associativity when the same rule/operator
expr
returns [double x]
    : NUMBER {
        // When you name something from the grammar, put a $ in front of it.
        $x = Double.parseDouble($NUMBER.text);
    }
    | PI {
        $x = Math.PI;
    }
    | op=('+' | '-') expr {
        if ($op.text.equals("-"))
            $x = -$expr.x;
        else
            $x = $expr.x;
    }
    | l=expr op=('*' | '/') r=expr {
        if ($op.text.equals("*"))
                $x = $l.x * $r.x;
            else
                $x = $l.x / $r.x;
    }
    | l=expr op=('+' | '-') r=expr {
        if ($op.text.equals("+"))
            $x = $l.x + $r.x;
        else
            $x = $l.x - $r.x;
    }
    | '(' expr ')' {
        $x = $expr.x;
    }
    ;

NUMBER
    : [0-9]+
    | [0-9]+ '.' [0-9]+
    ;

PI
    : 'pi'
    | 'π'
    ;

WHITESPACE
    : [ \r\n\t]+    -> skip
    ;