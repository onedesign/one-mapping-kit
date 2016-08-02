# One Mapping Kit

A simple Swift library from mapping JSON strings to Swift objects, and serializing them back into JSON.

## Errors

In the event of error, `OneMappingKit` will throw an `ErrorType` of `ODCMappingError`, with the possible values:

* `InvalidKey`: for cases where the key passed while mapping is an empty string or nil
* `NotFound(String)`: when the key is valid but the dictionary being mapped doesn't contain it
* `InvalidType(String)`: when the key is valid, and there is a value, but it cannot be cast to the type needed
