// JavaScript implementation for TCP sockets using Node.js net module
// This file provides the actual socket operations for the FFI
// Note: This is a simplified synchronous wrapper for demonstration

const net = require('net');

// Store active sockets
const sockets = new Map();
let nextSocketId = 1;

// Error codes
const ERROR_CODES = {
    NONE: 0,
    CONNECTION_REFUSED: 1,
    TIMEOUT: 2,
    CLOSED: 3,
    INVALID_SOCKET: 4,
    UNKNOWN: 5
};

// Get error message from code
function getErrorMessage(code) {
    switch (code) {
        case ERROR_CODES.CONNECTION_REFUSED:
            return 'Connection refused';
        case ERROR_CODES.TIMEOUT:
            return 'Operation timed out';
        case ERROR_CODES.CLOSED:
            return 'Socket closed';
        case ERROR_CODES.INVALID_SOCKET:
            return 'Invalid socket';
        default:
            return 'Unknown error';
    }
}

// Connect to a TCP socket (synchronous wrapper)
function ibmoon_socket_connect(host, port, timeout_ms) {
    // Note: Node.js net.Socket.connect is asynchronous
    // This is a simplified implementation that returns immediately
    // In a real implementation, you would need to use async/await or callbacks
    const socketId = nextSocketId++;
    const socket = new net.Socket();

    // Store socket immediately (simplified)
    sockets.set(socketId, socket);

    // Try to connect (this will be asynchronous in reality)
    socket.connect(port, host);

    // Return success immediately (this is a placeholder)
    // In production, you would wait for the connection to complete
    return { success: true, value: socketId, error: ERROR_CODES.NONE };
}

// Send data through socket (synchronous wrapper)
function ibmoon_socket_send(socket_id, data, length) {
    const socket = sockets.get(socket_id);

    if (!socket) {
        return { success: false, value: 0, error: ERROR_CODES.INVALID_SOCKET };
    }

    try {
        // Convert byte array to Buffer
        const buffer = Buffer.from(data);
        const bytesToSend = length > 0 ? Math.min(length, buffer.length) : buffer.length;

        // Write to socket (this is asynchronous in Node.js)
        const written = socket.write(buffer.slice(0, bytesToSend));

        // Return success immediately (simplified)
        return { success: true, value: bytesToSend, error: ERROR_CODES.NONE };
    } catch (e) {
        return { success: false, value: 0, error: ERROR_CODES.UNKNOWN };
    }
}

// Receive data from socket (synchronous wrapper)
function ibmoon_socket_receive(socket_id, buffer, length, timeout_ms) {
    const socket = sockets.get(socket_id);

    if (!socket) {
        return { success: false, value: 0, error: ERROR_CODES.INVALID_SOCKET };
    }

    // Note: Reading from socket is asynchronous in Node.js
    // This is a simplified implementation that returns immediately
    // In a real implementation, you would need to use async/await or callbacks

    // Return 0 bytes read (placeholder)
    return { success: true, value: 0, error: ERROR_CODES.NONE };
}

// Close socket (synchronous wrapper)
function ibmoon_socket_close(socket_id) {
    const socket = sockets.get(socket_id);

    if (!socket) {
        return { success: false, value: 0, error: ERROR_CODES.INVALID_SOCKET };
    }

    try {
        socket.end();
        socket.destroy();
        sockets.delete(socket_id);
        return { success: true, value: 0, error: ERROR_CODES.NONE };
    } catch (e) {
        return { success: false, value: 0, error: ERROR_CODES.UNKNOWN };
    }
}

// Get error message from error code
function ibmoon_socket_get_error(error_code) {
    return getErrorMessage(error_code);
}

// Export functions for FFI
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        ibmoon_socket_connect,
        ibmoon_socket_send,
        ibmoon_socket_receive,
        ibmoon_socket_close,
        ibmoon_socket_get_error
    };
}