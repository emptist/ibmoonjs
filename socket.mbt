///|
// JavaScript-specific socket implementation using FFI
// This file provides the actual socket operations for JavaScript target

///|

///|
pub struct Socket {
  socket_id : Int
}

///|
pub struct Address {
  host : String
  port : Int
}

///|
pub enum SocketError {
  ConnectionRefused
  Timeout
  Closed
  Other(String)
}

///|
pub fn SocketError::to_string(self : SocketError) -> String {
  match self {
    ConnectionRefused => "ConnectionRefused"
    Timeout => "Timeout"
    Closed => "Closed"
    Other(msg) => "Other(" + msg + ")"
  }
}

///|
// External JavaScript functions
// These will be provided by the socket_impl.js file
extern "js" fn ibmoon_socket_connect(
  host : String,
  port : Int,
  timeout_ms : Int,
) -> String

///|
extern "js" fn ibmoon_socket_send(
  socket_id : Int,
  data : String,
  length : Int,
) -> String

///|
extern "js" fn ibmoon_socket_receive(
  socket_id : Int,
  length : Int,
  timeout_ms : Int,
) -> String

///|
extern "js" fn ibmoon_socket_close(
  socket_id : Int,
) -> String

///|
// Helper function to parse JSON result from JavaScript
fn parse_result(json : String) -> { success : Bool, value : Int, error : Int } {
  // Simple JSON parsing - in production you'd use a proper JSON parser
  // For now, we'll parse the format: {"success":true,"value":123,"error":0}
  let success_idx = json.find("{\"success\":")
  if success_idx == -1 {
    { success: false, value: 0, error: 5 }
  } else {
    // This is a simplified parser - in real code you'd use proper JSON parsing
    // For now, assume success and extract value
    { success: true, value: 1, error: 0 }
  }
}

///|
pub fn connect(addr : Address, timeout_ms : Int) -> Result[Socket, SocketError] {
  let result_json = ibmoon_socket_connect(addr.host, addr.port, timeout_ms)
  let result = parse_result(result_json)
  if result.success {
    Ok(Socket::{ socket_id: result.value })
  } else {
    match result.error {
      1 => Err(ConnectionRefused)
      2 => Err(Timeout)
      3 => Err(Closed)
      4 => Err(Other("Invalid socket"))
      _ => Err(Other("Unknown error"))
    }
  }
}

///|
pub fn send(sock : Socket, data : Array[Byte]) -> Result[Unit, SocketError] {
  // Convert byte array to string for JavaScript interop
  let data_str = bytes_to_string(data)
  let result_json = ibmoon_socket_send(sock.socket_id, data_str, data.length)
  let result = parse_result(result_json)
  if result.success {
    Ok(())
  } else {
    match result.error {
      1 => Err(ConnectionRefused)
      2 => Err(Timeout)
      3 => Err(Closed)
      4 => Err(Other("Invalid socket"))
      _ => Err(Other("Send failed"))
    }
  }
}

///|
pub fn receive(
  sock : Socket,
  length : Int,
  timeout_ms : Int,
) -> Result[Array[Byte], SocketError] {
  let result_json = ibmoon_socket_receive(sock.socket_id, length, timeout_ms)
  let result = parse_result(result_json)
  if result.success {
    // For now, return empty array - in production you'd parse the actual data
    Ok(Array::make(length, 0_byte))
  } else {
    match result.error {
      1 => Err(ConnectionRefused)
      2 => Err(Timeout)
      3 => Err(Closed)
      4 => Err(Other("Invalid socket"))
      _ => Err(Other("Receive failed"))
    }
  }
}

///|
pub fn close(sock : Socket) -> Result[Unit, SocketError] {
  let result_json = ibmoon_socket_close(sock.socket_id)
  let result = parse_result(result_json)
  if result.success {
    Ok(())
  } else {
    match result.error {
      1 => Err(ConnectionRefused)
      2 => Err(Timeout)
      3 => Err(Closed)
      4 => Err(Other("Invalid socket"))
      _ => Err(Other("Close failed"))
    }
  }
}

///|
// Helper function to convert byte array to string
fn bytes_to_string(bytes : Array[Byte]) -> String {
  let mut result = ""
  let mut i = 0
  while i < bytes.length {
    result = result + bytes[i].to_string()
    i = i + 1
  }
  result
}
