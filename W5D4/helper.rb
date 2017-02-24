If numsLeft > 0, then:

Prompt the user for a number (use reader).

Pass a callback that:

Uses parseInt to parse the input.

Increment the sum and console.log it.

Recursively calls addNumbers again, passing in:

the increased sum,

the decreased numsLeft,

and the same completionCallback.

If numsLeft === 0, call completionCallback(sum) so that the total sum can be used.
