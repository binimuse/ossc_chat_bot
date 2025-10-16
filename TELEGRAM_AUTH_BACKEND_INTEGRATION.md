# Telegram Authentication UI Implementation

## Overview
This document describes the Telegram-based authentication UI implementation in the Flutter app. The current implementation includes demo functionality and UI components ready for backend integration.

## API Endpoints Required

### Base URL
```
http://142.132.228.77:3000/api/v1/
```

### 1. Send OTP for Login
**Endpoint:** `POST /auth/telegram/send-otp`

**Request Body:**
```json
{
  "phone_number": "+1234567890"
}
```

**Response (Success):**
```json
{
  "success": true,
  "message": "OTP sent successfully to your Telegram",
  "data": {
    "phone_number": "+1234567890",
    "otp_expires_in": 300
  }
}
```

**Response (Error):**
```json
{
  "success": false,
  "message": "Failed to send OTP. Please try again.",
  "error": "INVALID_PHONE_NUMBER"
}
```

### 2. Send OTP for Registration
**Endpoint:** `POST /auth/telegram/send-otp-registration`

**Request Body:**
```json
{
  "phone_number": "+1234567890",
  "full_name": "John Doe"
}
```

**Response (Success):**
```json
{
  "success": true,
  "message": "OTP sent successfully to your Telegram",
  "data": {
    "phone_number": "+1234567890",
    "full_name": "John Doe",
    "otp_expires_in": 300
  }
}
```

**Response (Error):**
```json
{
  "success": false,
  "message": "Failed to send OTP. Please try again.",
  "error": "INVALID_PHONE_NUMBER"
}
```

### 3. Verify OTP
**Endpoint:** `POST /auth/telegram/verify-otp`

**Request Body:**
```json
{
  "phone_number": "+1234567890",
  "otp_code": "123456",
  "is_registration": false,
  "full_name": "John Doe"  // Only required for registration
}
```

**Response (Success - Login):**
```json
{
  "success": true,
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user123",
    "phone_number": "+1234567890",
    "full_name": "John Doe",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

**Response (Success - Registration):**
```json
{
  "success": true,
  "message": "Account created successfully",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user123",
    "phone_number": "+1234567890",
    "full_name": "John Doe",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

**Response (Error):**
```json
{
  "success": false,
  "message": "Invalid OTP code. Please try again.",
  "error": "INVALID_OTP"
}
```

### 4. Resend OTP
**Endpoint:** `POST /auth/telegram/resend-otp`

**Request Body:**
```json
{
  "phone_number": "+1234567890",
  "is_registration": false,
  "full_name": "John Doe"  // Only required for registration
}
```

**Response (Success):**
```json
{
  "success": true,
  "message": "OTP resent successfully",
  "data": {
    "phone_number": "+1234567890",
    "otp_expires_in": 300
  }
}
```

## Error Codes

| Error Code | Description |
|------------|-------------|
| `INVALID_PHONE_NUMBER` | Phone number format is invalid |
| `INVALID_OTP` | OTP code is incorrect or expired |
| `OTP_EXPIRED` | OTP has expired |
| `TOO_MANY_ATTEMPTS` | Too many OTP requests |
| `USER_NOT_FOUND` | User not found (for login) |
| `USER_ALREADY_EXISTS` | User already exists (for registration) |
| `TELEGRAM_ERROR` | Error sending message via Telegram |

## Implementation Notes

### 1. OTP Generation
- Generate a 6-digit numeric OTP
- OTP should be valid for 5 minutes (300 seconds)
- Store OTP with expiration time in database

### 2. Telegram Integration
- Use Telegram Bot API to send OTP messages
- Message format: "Your OSS Chat Bot verification code is: 123456"
- Include app name and security warning in message

### 3. Rate Limiting
- Implement rate limiting: max 3 OTP requests per phone number per hour
- Implement cooldown period: 60 seconds between resend requests

### 4. Security Considerations
- Hash OTP codes in database
- Implement proper input validation
- Use HTTPS for all endpoints
- Implement proper error handling without exposing sensitive information

### 5. Database Schema
```sql
-- OTP Table
CREATE TABLE otp_codes (
  id VARCHAR(255) PRIMARY KEY,
  phone_number VARCHAR(20) NOT NULL,
  otp_hash VARCHAR(255) NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  is_used BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Users Table (if not exists)
CREATE TABLE users (
  id VARCHAR(255) PRIMARY KEY,
  phone_number VARCHAR(20) UNIQUE NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Testing

### Test Phone Numbers
- Use test phone numbers for development
- For production, implement proper phone number validation

### Test OTP
- For development, you can use a fixed OTP (e.g., "123456")
- Ensure test OTP works for both login and registration flows

## Frontend Integration

The Flutter app is already configured to work with these endpoints. The following files have been updated:

1. **Constants** (`lib/app/utils/constants.dart`)
   - Added Telegram authentication endpoints

2. **Service** (`lib/app/common/services/telegram_auth_service.dart`)
   - Complete service for handling all Telegram auth operations

3. **Controllers** 
   - `LoginController` - Handles login with Telegram
   - `RegisterController` - Handles registration with Telegram
   - `OtpController` - Handles OTP verification

4. **UI Components**
   - Updated login and registration screens with Telegram branding
   - OTP verification screen with Telegram icon

## Current Implementation Status

✅ **UI Implementation Complete**
- Login screen with Telegram branding
- Registration screen with Telegram branding  
- OTP verification screen with Telegram icon
- Demo functionality working with any 6-digit OTP

## Demo Functionality

The current implementation includes demo functionality:
- **Login**: Enter any phone number → Navigate to OTP screen
- **Registration**: Enter name + phone number → Navigate to OTP screen  
- **OTP Verification**: Enter any 6-digit number → Navigate to home screen
- **Resend OTP**: Works with 60-second timer

## Next Steps for Backend Integration

1. Implement the backend endpoints as specified
2. Set up Telegram Bot integration
3. Replace demo logic with real API calls
4. Test the complete flow
5. Deploy to production

## Support

If you need any clarification on the API specification or have questions about the integration, please refer to the Flutter code comments or contact the frontend development team.
