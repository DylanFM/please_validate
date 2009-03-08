#Please validate

A little command-line markup validator.

Requires colored and nokogiri gems.
    gem install colored nokogiri

##Example

###Valid file
    $ bin/pleasevalidate examples/valid.html
    Valid: examples/valid.html

###Invalid file

    $ bin/pleasevalidate examples/invalid.html
    Invalid: examples/invalid.html
    11 errors:
    Line 8, Column 19: end tag for element "itle" which is not open
    Line 10, Column 6: end tag for "title" omitted, but OMITTAG NO was specified
    Line 8, Column 1: start tag was here
    Line 16, Column 5: document type does not allow element "ul" here; missing one of "object", "ins", "del", "map", "button" start-tag
    Line 20, Column 0: unclosed end-tag requires SHORTTAG YES
    Line 20, Column 0: end tag for "li" omitted, but OMITTAG NO was specified
    Line 17, Column 4: start tag was here
    Line 20, Column 0: end tag for "ul" omitted, but OMITTAG NO was specified
    Line 16, Column 2: start tag was here
    Line 20, Column 0: end tag for "p" omitted, but OMITTAG NO was specified
    Line 15, Column 2: start tag was here
    Line 8, Column 20: XML Parsing Error:  Opening and ending tag mismatch: title line 8 and itle
    Line 20, Column 7: XML Parsing Error:  expected '>'
    Line 20, Column 7: XML Parsing Error:  Premature end of data in tag p line 15
    Line 20, Column 7: XML Parsing Error:  Premature end of data in tag body line 12
    Line 20, Column 7: XML Parsing Error:  Premature end of data in tag html line 4
