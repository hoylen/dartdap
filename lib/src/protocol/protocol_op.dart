part of ldap_protocol;

class ProtocolOp {
  
  int _protocolOp;
  
  /** 
   * All LDAP ops are async excecpt for BIND / Start TLS - which must be synchronous
   */
  bool _syncOp = false;
  
  int get protocolOp  => _protocolOp;
  
  bool get isSync => _syncOp;
  
  
  /**
   * Create a sequence that is the start of the protocol op
   * Sublclasses must add additional elements
   */
  ASN1Sequence _startSequence() {
    var seq = new ASN1Sequence(_protocolOp);
  
    return seq;
  }
}


abstract class RequestOp extends ProtocolOp {
  
 
  
  
  /**
   * Subclasses must implement this method to convert their 
   * representation to an ASN1Sequence
   */
  ASN1Sequence toASN1Sequence();
  /**
   * Encode this Request Operation to its BER Encoded form
   */
  Uint8List toEncodedBytes() {
    ASN1Sequence seq = toASN1Sequence();
    seq.encode();
    return seq.encodedBytes;
  }
  
}

class ResponseOp extends ProtocolOp {
  LDAPResult _ldapResult;
  int _opCode;
  
  LDAPResult get ldapResult => _ldapResult;
  
  ResponseOp.fromSequence(ASN1Sequence s) {
    _opCode = s.tag;
    _ldapResult = new LDAPResult.fromSequence(s);
  }
  
}


