module dependency;

@nogc @safe bool isValidKey(String)(String key) pure nothrow if (is(String : const(char)[])) {
    @nogc @safe static bool isValidKeyChar(char c) pure nothrow {
        return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9') || c == '-';
    }
    
    if (key.length == 0) {
        return false;
    }
    for (size_t i = 0; i<key.length; ++i) {
        if (!isValidKeyChar(key[i])) {
            return false;
        }
    }
    return true;
}

///
unittest
{
    assert(isValidKey("Generic-Name"));
    assert(!isValidKey("Name$"));
    assert(!isValidKey(""));
}
