# One Mapping Kit

A simple Swift library from mapping JSON strings to Swift objects, and serializing them back into JSON.

## Mapping

In order to map your class, it must inherit from `ODCMappableObject`.

To make your class mappable, you need only declare all your instance variables, required or optional, and map them using `func mapping(mapper: ODCMapper)`.

### Class Declaration

Here's an example object, which has some required fields and some optional fields:

```
class MockObject: ODCMappableObject {
    var requiredInt: Int!
    var requiredString: String!
    var optionalInt: Int?
    var optionalString: String?
    var stringWithDefault: String = "default value"

    override func mapping(mapper: ODCMapper) throws {
        //TODO
    }
}
```

#### Required Variables

Required variables without an initial value must be declared as _implicitly unwrapped optionals_. This means your type must be followed by an `!`.
This is because `ODCMappableObject` must be able to call `super.init()` before validating your parameters. When mapping, you must use the keyword `try`,
because the mapping will throw an instance of `ODCMappingError` if the key is not found or fails to cast.

```
class MockObject: ODCMappableObject {
    var requiredInt: Int!

    override func mapping(mapper: ODCMapper) throws {
        //TODO
    }
}

#### Required Variables with an Initial Value

If your required variables have a default value, you needn't implicitly unwrap them, because they already have a value.
Likewise, no error will be thrown if there is no value or if it is invalid.
If your JSON string or NSDictionary does not have a value at this key, it will retain the default value:

```
class MockObject: ODCMappableObject {
    var stringWithDefault: String = "default"

    override func mapping(mapper: ODCMapper) throws {
        //TODO
    }
}

let mockObject = MockObject(["someOtherKey": "value"])
print(mockObject.stringWithDefault) // => "default"
print(mockObject.serialize()) // => ["stringWithDefault": "default"]
```

#### Optional Variables

Optional variables are the easiest to deal with:

```
class MockObject: ODCMappableObject {
    var optionalInt: Int?

    override func mapping(mapper: ODCMapper) throws {
        //TODO
    }
}
```

#### Unmapped Variables

Your class can contain unmapped variables as well. Like required variables, these _must_ be implicitly unwrapped or have a default value.
As of now, this means that they won't be included in the serialization:

```
class MockObject: ODCMappableObject {
    var unmappedVariable: String = "default"
    var unmappedUnwrappedVariable: String!

    override func mapping(mapper: ODCMapper) throws {
    }
}
let myObject = MockObject()
print(myObject.unmappedVariable) // => "default"
myObject.unmappedUnwrappedVariable = "hello world"
```

### Instantiation

You can instantiate your mappable object in a number of ways:

```
//the old fashioned way:
let myObject = MockObject()
myObject.requiredInt = 7
myObject.requiredString = "string"
let dict = myObject.serialize()

//using a JSON string:
let json = "{\"requiredInt\": 7, \"requiredString\": \"string\"}"
let myObject = MockObject(json: json) //fails for invalid json
let dict = myObject?.serialize()

//using an NSDictionary:
let data = ["requiredInt": 7, "requiredString": "string"]
let myObject = MockObject(data)
let dict = myObject?.serialize()
```

#### Failable Initializers

When instantiating using either a JSON string or an NSDictionary, the initializer is failable, and returns nil in the event that the data is invalid.
This includes invalid JSON strings and JSON/dictionaries that don't include required values. Consider the example `MockObject` above:

```
let myObject = MockObject() //will never return nil
let dict = myObject.serialize() //fatal error, requiredInt and requiredString not defined

let myObject = MockObject(json: "{\"requiredInt\": 7}") //missing requiredString, returns nil
let dict = myObject?.serialize() //returns nil

let myObject = MockObject(["requiredInt": 7]) //missing requiredString, returns nil
let dict = myObject?.serialize() //returns nil
```

## Errors

In the event of error, `OneMappingKit` will throw an `ErrorType` of `ODCMappingError`, with the possible values:

* `InvalidKey`: for cases where the key passed while mapping is an empty string or nil
* `NotFound(String)`: when the key is valid but the dictionary being mapped doesn't contain it
* `InvalidType(String)`: when the key is valid, and there is a value, but it cannot be cast to the type needed
