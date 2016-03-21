module dependent;
import dependency;

unittest
{
    assert(isValidKey("Generic-Name"));
    assert(!isValidKey("Name$"));
}