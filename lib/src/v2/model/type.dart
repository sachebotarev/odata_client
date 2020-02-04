
enum Kind{
  PRIMITIVE,
  COMPLEX
}

class Identifier {

}

class TraitsType {

}

class Type {
   Kind kind;
   bool isCollection;
   String initialValue;
   TraitsType traitsType;  


}

class Collection extends Type {

}

class StructType extends Type{
  
}