# IB MoonBit API Wrapper - JavaScript/Node.js Target

**Purpose**: This is the JavaScript/Node.js target-specific implementation of the IB TWS/Gateway API wrapper for MoonBit.

## Why This Project Exists?

Due to a MoonBit language limitation, the main [ibmoon](../ibmoon) project cannot use target-specific FFI implementations when building with explicit targets. This project provides a working JavaScript/Node.js implementation that uses the JavaScript FFI layer directly.

**See the [main ibmoon project](../ibmoon) for complete documentation on the FFI limitation and why multiple target-specific projects are needed.**

## Features

- **Target**: JavaScript/Node.js
- **FFI Implementation**: Uses Node.js `net` module for socket operations
- **Use Case**: Server-side applications, Node.js environments
- **Performance**: Good for I/O-bound operations

## Installation

```bash
# Add this project as a dependency in your moon.pkg.json
{
  "import": [
    {
      "path": "../ibmoonjs",
      "alias": "ibmoon"
    }
  ]
}
```

## Building

```bash
# Build for JavaScript target
moon build --target js

# Run tests
moon test --target js
```

## Usage

```moonbit
import "ibmoon"

// Create client
let config = ibmoon::connection_config("127.0.0.1", 7496, 1, None)
let client = ibmoon::new_client(config)

// Connect
match ibmoon::client_connect(client) {
  Ok(client) => {
    println("Connected to IB TWS/Gateway")
    
    // Set up callbacks
    let client = ibmoon::set_managed_accounts_callback(client, fn(accounts : String) {
      println("Accounts: " + accounts)
    })
    
    // Request managed accounts
    match ibmoon::req_managed_accounts(client) {
      Ok(_) => {
        // Process messages
        for i = 0; i < 10; i = i + 1 {
          ibmoon::client_process_messages(client)
        }
      }
      Err(e) => ()
    }
    
    // Disconnect
    ibmoon::client_disconnect(client)
  }
  Err(e) => {
    println("Failed to connect")
  }
}
```

## Running Examples

```bash
# Run managed accounts example
moon run --target js cmd/main/example_managed_accounts

# Run account summary example
moon run --target js cmd/main/example_account_summary

# Run positions example
moon run --target js cmd/main/example_positions
```

## Prerequisites

- **Node.js**: Required for JavaScript runtime (v14 or higher recommended)
- **IB TWS or IB Gateway**: Must be running and configured with API access
- **API Port**: Default is 7496 for paper trading, 7497 for live trading
- **API Connections**: Must be enabled in TWS/Gateway settings

## Testing with Live IB API

To test with a live IB API:

1. Start IB TWS or IB Gateway
2. Enable API connections on port 7496
3. Ensure client ID is not already in use
4. Run integration test:

```bash
moon test --target js
```

## Architecture

### Socket Layer
- **File**: `socket.mbt`
- **FFI File**: `socket_impl.js`
- **Implementation**: Uses Node.js `net` module for TCP connections

### Core Files
All core IB API files are included:
- `types.mbt` - Data types for contracts, orders, etc.
- `orders.mbt` - Order types and helpers
- `protocol.mbt` - Message protocol definitions
- `encoder.mbt` - Message encoding
- `decoder.mbt` - Message decoding
- `client.mbt` - Connection and client management
- `api.mbt` - High-level API wrapper
- `handlers.mbt` - Message handlers for callbacks

## JavaScript-Specific Notes

- **Runtime**: Requires Node.js environment
- **Async I/O**: Node.js uses non-blocking I/O, but our FFI provides synchronous wrappers
- **Error Handling**: JavaScript errors are converted to MoonBit `Result` types
- **Socket Lifecycle**: Sockets are automatically managed by Node.js garbage collector

## Limitations

- **Browser Not Supported**: This target requires Node.js runtime, not browser JavaScript
- For browser support, use the [ibmoonwa](../ibmoonwa) project (WebAssembly target)

## Related Projects

- **[ibmoon](../ibmoon)** - Main project with complete documentation
- **[ibmoonc](../ibmoonc)** - C/Native target for native performance
- **[ibmoonwa](../ibmoonwa)** - WebAssembly target for browser environments

## License

Apache-2.0 - See [LICENSE](LICENSE) file for details

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## Support

- **Documentation**: See [ibmoon/docs](../ibmoon/docs) for comprehensive documentation
- **Issues**: Report issues in the main [ibmoon](../ibmoon) repository
- **FFI Details**: See [ibmoon/docs/FFI_INTEGRATION_GUIDE.md](../ibmoon/docs/FFI_INTEGRATION_GUIDE.md)