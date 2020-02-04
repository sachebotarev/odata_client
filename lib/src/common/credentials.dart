abstract class Credentials {
  Map<String, String> getHeaders(){
    return null;
  }
}

class NoCredentials extends Credentials {

}

class HTTPBasicCredentials extends Credentials {

  HTTPBasicCredentials(String  username, String password){
  }
}

class HTTPSMPCredentials extends Credentials {
  
}