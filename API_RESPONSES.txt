# EMR Application — API Response Documentation

> **Version:** 1.0  
> **Last Updated:** March 11, 2026  
> **Base URL:** `https://api.emr-app.com/v1`

---

## Table of Contents

1. [Authentication](#1-authentication)
2. [Patient Profile](#2-patient-profile)
3. [Appointments](#3-appointments)
4. [Consultations](#4-consultations)
5. [Prescriptions & Records](#5-prescriptions--records)
6. [Medications](#6-medications)
7. [Reports](#7-reports)
8. [Notifications](#8-notifications)
9. [Chat / Messaging](#9-chat--messaging)
10. [Zoom Video Call](#10-zoom-video-call)
11. [Settings](#11-settings)
12. [Error Responses](#12-error-responses)

---

## 1. Authentication

### 1.1 Login

**`POST /auth/login`**

#### Request Body

```json
{
  "patientId": "user",
  "password": "1234"
}
```

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "message": "Login successful!",
  "data": {
    "userId": "user",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJ1c2VyIiwiaWF0IjoxNzEwMTU4Nzg0fQ.abc123",
    "refreshToken": "rt_abc123def456",
    "expiresIn": 3600,
    "patient": {
      "id": "PH10032-7891",
      "name": "Sarah Johnson",
      "age": 29,
      "gender": "Female",
      "avatar": "assets/images/sarah.jpg"
    }
  }
}
```

#### ❌ Error Response — `401 Unauthorized`

```json
{
  "status": "error",
  "message": "Invalid username or password",
  "errorCode": "AUTH_INVALID_CREDENTIALS"
}
```

---

### 1.2 Check Login Status

**`GET /auth/status`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": {
    "isLoggedIn": true,
    "userId": "user"
  }
}
```

---

### 1.3 Logout

**`POST /auth/logout`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "message": "Logged out successfully"
}
```

---

## 2. Patient Profile

### 2.1 Get Patient Profile

**`GET /patients/{patientId}`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": {
    "id": "PH10032-7891",
    "name": "Sarah Johnson",
    "age": 29,
    "gender": "Female",
    "avatar": "assets/images/sarah.jpg",
    "personalInfo": {
      "phone": "+1 (555) 123-4567",
      "email": "sarah.johnson@gmail.com",
      "address": "123 Oak Street, Austin, TX",
      "emergencyContact": {
        "name": "John Johnson",
        "phone": "+1 (555) 987-6543"
      }
    },
    "vitals": {
      "height": "170 cm",
      "weight": "65 kg",
      "bloodPressure": "120/80 mmHg",
      "pulse": "72 bpm",
      "spO2": "98%",
      "temperature": "37.2°C"
    },
    "medicalInfo": {
      "bloodGroup": "O+ Positive",
      "allergies": ["Chloramphenicol"],
      "problems": ["Asthma", "Allergic Rhinitis"],
      "surgeries": ["Septoplasty"]
    }
  }
}
```

---

## 3. Appointments

### 3.1 Book Appointment

**`POST /appointments`**

#### Request Body

```json
{
  "doctorName": "Dr. Michael Chen",
  "date": "15/03/2026",
  "time": "2:30 PM",
  "priority": "Routine",
  "message": "Follow-up for blood pressure monitoring",
  "status": "Confirmed"
}
```

#### ✅ Success Response — `201 Created`

```json
{
  "status": "success",
  "message": "Appointment Submitted!",
  "data": {
    "appointmentId": "APT-2026-0315-001",
    "doctorName": "Dr. Michael Chen",
    "specialty": "Cardiologist",
    "date": "15/03/2026",
    "time": "2:30 PM",
    "priority": "Routine",
    "message": "Follow-up for blood pressure monitoring",
    "status": "Confirmed",
    "type": "Online Consultation",
    "createdAt": "2026-03-11T12:00:00Z"
  }
}
```

#### ❌ Validation Error — `422 Unprocessable Entity`

```json
{
  "status": "error",
  "message": "Please fill all required fields",
  "errors": [
    { "field": "doctorName", "message": "Doctor selection is required" },
    { "field": "date", "message": "Appointment date is required" }
  ]
}
```

---

### 3.2 Get All Appointments

**`GET /appointments`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": [
    {
      "appointmentId": "APT-2026-0315-001",
      "doctorName": "Dr. Michael Chen",
      "specialty": "Cardiologist",
      "date": "15/03/2026",
      "time": "2:30 PM",
      "priority": "Routine",
      "status": "Confirmed",
      "type": "Online Consultation",
      "doctorImage": "assets/images/doctor.png"
    },
    {
      "appointmentId": "APT-2026-0220-002",
      "doctorName": "Dr. Sarah Johnson",
      "specialty": "Cardiologist",
      "date": "20/02/2026",
      "time": "10:30 AM",
      "priority": "Urgent",
      "status": "Confirmed",
      "type": "Video Call",
      "doctorImage": "assets/images/doctor.png"
    }
  ]
}
```

---

### 3.3 Delete Appointment

**`DELETE /appointments/{index}`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "message": "Appointment deleted successfully"
}
```

---

## 4. Consultations

### 4.1 Get Upcoming Consultations

**`GET /consultations?type=upcoming`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": [
    {
      "id": "CON-2026-001",
      "doctorName": "Dr. Michael Chen",
      "specialty": "General Practitioner",
      "date": "15/03/2026",
      "time": "2:30 PM",
      "type": "Online Consultation",
      "status": "Confirmed",
      "statusColor": "#E8F5E9",
      "statusTextColor": "#2E7D32",
      "doctorImage": "assets/images/doctor.png",
      "bookingId": "APT-2026-0315-001"
    }
  ]
}
```

---

### 4.2 Get Past Consultations

**`GET /consultations?type=past`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": [
    {
      "id": "CON-2024-101",
      "doctorName": "Dr. Michael Chen",
      "specialty": "Cardiologist",
      "date": "Mar 12 2024, 2:30 PM",
      "type": "Online Consultation",
      "status": "Completed",
      "doctorImage": "assets/images/doctor.png"
    },
    {
      "id": "CON-2024-102",
      "doctorName": "Dr. Antony Nicholas",
      "specialty": "Dermatologist",
      "date": "Jan 19 2024, 11:15 AM",
      "type": "In-person Visit",
      "status": "Completed",
      "doctorImage": "assets/images/doctor.png"
    },
    {
      "id": "CON-2024-103",
      "doctorName": "Dr. Emily Rodriguez",
      "specialty": "Pediatrician",
      "date": "Jan 19 2024, 11:15 AM",
      "type": "In-person Visit",
      "status": "Completed",
      "doctorImage": "assets/images/doctor.png"
    }
  ]
}
```

---

### 4.3 Get Consultation Details

**`GET /consultations/{consultationId}`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": {
    "id": "CON-2026-001",
    "doctor": {
      "name": "Dr. Michael Chen",
      "specialty": "Cardiologist",
      "image": "assets/images/doctor.png"
    },
    "appointment": {
      "date": "Today, March 15, 2024",
      "timeSlot": "2:30 PM - 3:00 PM",
      "type": "Online Consultation",
      "description": "Video call via secure platform",
      "bookingId": "APT-2024-0315-001"
    },
    "status": "Confirmed",
    "startsIn": "10 minutes"
  }
}
```

---

### 4.4 Filter Consultations

**`GET /consultations?status=Confirmed&type=Online`**

#### Query Parameters

| Parameter | Type     | Values                                         |
|-----------|----------|-------------------------------------------------|
| `status`  | `string` | `All`, `Confirmed`, `Completed`, `Cancelled`, `Pending` |
| `type`    | `string` | `Online`, `In-person`                           |

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "filters": {
    "status": "Confirmed",
    "type": "Online"
  },
  "data": [
    {
      "id": "CON-2026-001",
      "doctorName": "Dr. Michael Chen",
      "specialty": "General Practitioner",
      "date": "15/03/2026",
      "time": "2:30 PM",
      "type": "Online Consultation",
      "status": "Confirmed"
    }
  ]
}
```

---

## 5. Prescriptions & Records

### 5.1 Get Prescription Records

**`GET /prescriptions/{consultationId}`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": {
    "consultationId": "CON-2025-001",
    "doctor": {
      "name": "Dr. Michael Chen",
      "specialty": "Cardiologist",
      "image": "assets/images/doctor.png"
    },
    "appointmentDate": "Mar 12 2025, 2:30 PM",
    "type": "Online Consultation",
    "status": "Confirmed",
    "doctorNotes": "Patient shows improvement in blood pressure. Continue current medication. Schedule follow-up in 4 weeks.",
    "prescriptionSummary": [
      {
        "name": "Antihistamines",
        "type": "Syrup",
        "dosage": "5ml",
        "schedule": "Morning",
        "instruction": "Empty stomach",
        "duration": "30 days"
      },
      {
        "name": "Leukotriene receptor antagonists",
        "type": "Tablet",
        "dosage": "+1",
        "schedule": "Morning, Afternoon, Evening",
        "instruction": "After meals",
        "duration": "90 days"
      }
    ],
    "attachments": [
      {
        "name": "ECG Report",
        "type": "pdf",
        "url": "/files/ecg_report_2025.pdf",
        "color": "#4A90D9"
      },
      {
        "name": "Lab Results",
        "type": "lab",
        "url": "/files/lab_results_2025.pdf",
        "color": "#4CAF50"
      }
    ],
    "dischargeInstructions": [
      "Take prescribed medicines regularly and monitor blood pressure twice daily.",
      "Avoid heavy physical exertion for the next few days.",
      "Follow a low-sodium diet and stay hydrated.",
      "Visit the clinic immediately if you experience chest pain or dizziness."
    ],
    "educationNotes": [
      "Learn about healthy lifestyle habits that support heart health – include more fruits, vegetables, and fiber in your meals.",
      "Avoid smoking, reduce caffeine, and practice deep breathing or relaxation exercises.",
      "Maintain a daily log of your blood pressure readings to share at your next appointment."
    ],
    "patientAcknowledgement": {
      "options": [
        "I understand fully",
        "I need more explanation",
        "I don't understand"
      ],
      "selectedOption": null
    }
  }
}
```

---

### 5.2 Submit Acknowledgement

**`POST /prescriptions/{consultationId}/acknowledge`**

#### Request Body

```json
{
  "understandingLevel": "I understand fully"
}
```

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "message": "Acknowledgement submitted successfully"
}
```

---

## 6. Medications

### 6.1 Get Current Medications

**`GET /medications?type=current`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": [
    {
      "id": "MED-001",
      "name": "Antihistamines",
      "type": "Syrup",
      "dosage": "5ml",
      "schedule": "Morning",
      "instruction": "Empty stomach",
      "duration": "90 days (until Jan 15, 2025)",
      "prescribedBy": "Dr. Sarah Johnson",
      "iconBg": "#E1BEE7",
      "iconAsset": "assets/images/tablet.png"
    },
    {
      "id": "MED-002",
      "name": "Leukotriene receptor antagonists",
      "type": "Tablet",
      "dosage": "+1",
      "schedule": "Morning, Afternoon, Evening",
      "instruction": "After meals",
      "duration": "90 days (until Jan 15, 2025)",
      "prescribedBy": "Dr. Sarah Johnson",
      "iconBg": "#BBDEFB",
      "iconAsset": "assets/images/syrup.png"
    },
    {
      "id": "MED-003",
      "name": "Inhaled corticosteroids (ICS)",
      "type": "Inhaler",
      "dosage": "2 puffs",
      "schedule": "As needed",
      "instruction": "",
      "duration": "As needed",
      "prescribedBy": "Dr. Sarah Johnson",
      "iconBg": "#C8E6C9",
      "iconAsset": "assets/images/inhaler.png"
    },
    {
      "id": "MED-004",
      "name": "Insulin",
      "type": "Injection",
      "dosage": "10 units",
      "schedule": "Evening",
      "instruction": "Before sleep",
      "duration": "30 days (until Sep 10, 2024)",
      "prescribedBy": "Dr. Sarah Johnson",
      "iconBg": "#FFE0B2",
      "iconAsset": "assets/images/injection.png"
    }
  ]
}
```

---

### 6.2 Get Past Medications

**`GET /medications?type=past`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": [
    {
      "id": "MED-P001",
      "name": "Antihistamines",
      "type": "Syrup",
      "dosage": "5ml",
      "schedule": "Morning",
      "instruction": "Empty stomach",
      "duration": "90 days (until Jan 15, 2025)",
      "prescribedBy": "Dr. Sarah Johnson",
      "iconBg": "#BDBDBD",
      "iconAsset": "assets/images/tablet_black.png"
    },
    {
      "id": "MED-P002",
      "name": "Leukotriene receptor antagonists",
      "type": "Tablet",
      "dosage": "+1",
      "schedule": "Morning, Afternoon, Evening",
      "instruction": "After meals",
      "duration": "90 days (until Jan 15, 2025)",
      "prescribedBy": "Dr. Sarah Johnson",
      "iconBg": "#757575",
      "iconAsset": "assets/images/syrup_black.png"
    }
  ]
}
```

---

## 7. Reports

### 7.1 Get All Reports

**`GET /reports`**

#### Query Parameters

| Parameter | Type     | Values                          |
|-----------|----------|---------------------------------|
| `type`    | `string` | `all`, `lab`, `scan`            |

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": [
    {
      "id": "RPT-001",
      "title": "Thyroid Function Test",
      "date": "Dec 5, 2024",
      "doctor": "Dr. Emily Davis · Gynecologist",
      "type": "lab",
      "iconPath": "assets/images/thyroid.png",
      "iconBg": "#E1BEE7",
      "iconColor": "#7986CB",
      "pdfUrl": "/files/reports/thyroid_function_test.pdf"
    },
    {
      "id": "RPT-002",
      "title": "p-DEXA Scan",
      "date": "Nov 13, 2024",
      "doctor": "Dr. Antony Nicholas · Orthopedist",
      "type": "scan",
      "iconPath": "assets/images/dexa.png",
      "iconBg": "#C8E6C9",
      "iconColor": "#4CAF50",
      "pdfUrl": "/files/reports/dexa_scan.pdf"
    }
  ]
}
```

---

### 7.2 Get Lab Reports Only

**`GET /reports?type=lab`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": [
    {
      "id": "RPT-001",
      "title": "Thyroid Function Test",
      "date": "Dec 5, 2024",
      "doctor": "Dr. Emily Davis · Gynecologist",
      "type": "lab",
      "iconPath": "assets/images/thyroid.png",
      "iconBg": "#E1BEE7",
      "iconColor": "#7986CB",
      "pdfUrl": "/files/reports/thyroid_function_test.pdf"
    }
  ]
}
```

---

### 7.3 Get Scan Reports Only

**`GET /reports?type=scan`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": [
    {
      "id": "RPT-002",
      "title": "p-DEXA Scan",
      "date": "Nov 13, 2024",
      "doctor": "Dr. Antony Nicholas · Orthopedist",
      "type": "scan",
      "iconPath": "assets/images/dexa.png",
      "iconBg": "#C8E6C9",
      "iconColor": "#4CAF50",
      "pdfUrl": "/files/reports/dexa_scan.pdf"
    }
  ]
}
```

---

## 8. Notifications

### 8.1 Get All Notifications

**`GET /notifications`**

#### Query Parameters

| Parameter | Type     | Values                                      |
|-----------|----------|----------------------------------------------|
| `type`    | `string` | `all`, `chat`, `call_missed`, `reminder`     |

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": [
    {
      "id": "1",
      "type": "chat",
      "title": "New Message",
      "body": "Dr. Sarah has sent you a message regarding your report.",
      "time": "2 mins ago",
      "isRead": false
    },
    {
      "id": "2",
      "type": "call_missed",
      "title": "Missed Video Call",
      "body": "You missed a scheduled video call from Dr. Michael Chen.",
      "time": "45 mins ago",
      "isRead": false
    },
    {
      "id": "3",
      "type": "reminder",
      "title": "Upcoming Consultation",
      "body": "Your consultation with Dr. Linda starts in 10 minutes.",
      "time": "10 mins ago",
      "isRead": true
    },
    {
      "id": "4",
      "type": "other",
      "title": "Prescription Ready",
      "body": "Your latest prescription has been uploaded and is ready for download.",
      "time": "2 hours ago",
      "isRead": true
    },
    {
      "id": "5",
      "type": "chat",
      "title": "New Message",
      "body": "The lab has uploaded your blood test results.",
      "time": "5 hours ago",
      "isRead": true
    },
    {
      "id": "6",
      "type": "call_missed",
      "title": "Missed Audio Call",
      "body": "You missed an audio check-up call from the nursing station.",
      "time": "Yesterday",
      "isRead": true
    }
  ]
}
```

---

### 8.2 Mark Notification as Read

**`PATCH /notifications/{notificationId}/read`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": {
    "id": "1",
    "isRead": true
  }
}
```

---

### 8.3 Clear All Notifications

**`DELETE /notifications`**

#### Query Parameters

| Parameter | Type     | Description                                       |
|-----------|----------|---------------------------------------------------|
| `type`    | `string` | Optional. Clear only a specific type (`chat`, `call_missed`, `reminder`). Omit to clear all. |

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "message": "Notifications cleared"
}
```

---

## 9. Chat / Messaging

### 9.1 Get Chat List

**`GET /chats`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": [
    {
      "id": "CHAT-001",
      "doctorName": "Dr. Michael Chen",
      "lastMessage": "Do you have any recent test reports?",
      "time": "1:23 PM",
      "hasUnread": true,
      "image": "assets/images/sarah.jpg"
    },
    {
      "id": "CHAT-002",
      "doctorName": "Dr. Antony Nicholas",
      "lastMessage": "Hello Doctor, I have a headache since last...",
      "time": "2:14 PM",
      "hasUnread": false,
      "image": "assets/images/michael_chen.jpg"
    },
    {
      "id": "CHAT-003",
      "doctorName": "Dr. Emily Rodriguez",
      "lastMessage": "typing...",
      "time": "1:23 PM",
      "hasUnread": false,
      "image": "assets/images/sarah.jpg"
    },
    {
      "id": "CHAT-004",
      "doctorName": "Dr. Patrick Johnson",
      "lastMessage": "Please check your blood test reports once...",
      "time": "12/09/25",
      "hasUnread": false,
      "image": "assets/images/doctor.png"
    }
  ]
}
```

---

### 9.2 Get Chat Messages

**`GET /chats/{chatId}/messages`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": {
    "chatId": "CHAT-001",
    "doctorName": "Dr. Michael Chen",
    "doctorImage": "assets/images/sarah.jpg",
    "messages": [
      {
        "id": "MSG-001",
        "type": "text",
        "text": "Good morning doctor, I've been having pressure when I walk fast. I also feel breathless.",
        "time": "12:40 PM",
        "isMe": true,
        "readStatus": "read"
      },
      {
        "id": "MSG-002",
        "type": "image",
        "text": "Here my X-rays",
        "time": "12:43 PM",
        "isMe": true,
        "readStatus": "read",
        "images": [
          "assets/images/xray.png",
          "assets/images/xray.png",
          "assets/images/xray.png"
        ]
      },
      {
        "id": "MSG-003",
        "type": "text",
        "text": "Do you have any recent test reports?",
        "time": "12:50 PM",
        "isMe": false,
        "quote": {
          "title": "You",
          "text": "5 Images"
        }
      },
      {
        "id": "MSG-004",
        "type": "file",
        "fileName": "Test_Report.pdf",
        "fileInfo": "4 pages . PDF . 2MB",
        "time": "01:00 PM",
        "isMe": true,
        "readStatus": "delivered",
        "fileUrl": "/files/chat/test_report.pdf"
      }
    ]
  }
}
```

---

### 9.3 Send Text Message

**`POST /chats/{chatId}/messages`**

#### Request Body

```json
{
  "type": "text",
  "text": "Thank you doctor, I will share the reports shortly."
}
```

#### ✅ Success Response — `201 Created`

```json
{
  "status": "success",
  "data": {
    "id": "MSG-005",
    "type": "text",
    "text": "Thank you doctor, I will share the reports shortly.",
    "time": "01:15 PM",
    "isMe": true,
    "readStatus": "sent"
  }
}
```

---

### 9.4 Send Image Message

**`POST /chats/{chatId}/messages`** (multipart/form-data)

#### Request Body

```
Content-Type: multipart/form-data

type: "image"
text: "Sent an image"
image: [binary file]
```

#### ✅ Success Response — `201 Created`

```json
{
  "status": "success",
  "data": {
    "id": "MSG-006",
    "type": "image",
    "text": "Sent an image",
    "time": "01:20 PM",
    "isMe": true,
    "readStatus": "sent",
    "images": ["https://cdn.emr-app.com/uploads/chat/img_12345.jpg"]
  }
}
```

---

### 9.5 Send File Message

**`POST /chats/{chatId}/messages`** (multipart/form-data)

#### Request Body

```
Content-Type: multipart/form-data

type: "file"
file: [binary file]
```

#### ✅ Success Response — `201 Created`

```json
{
  "status": "success",
  "data": {
    "id": "MSG-007",
    "type": "file",
    "fileName": "Blood_Test_Results.pdf",
    "fileInfo": "2.1 KB",
    "time": "01:25 PM",
    "isMe": true,
    "readStatus": "sent",
    "fileUrl": "https://cdn.emr-app.com/uploads/chat/blood_test_results.pdf"
  }
}
```

---

### 9.6 Send Voice Message

**`POST /chats/{chatId}/messages`** (multipart/form-data)

#### Request Body

```
Content-Type: multipart/form-data

type: "voice"
audio: [binary .m4a file]
duration: "1:23"
```

#### ✅ Success Response — `201 Created`

```json
{
  "status": "success",
  "data": {
    "id": "MSG-008",
    "type": "voice",
    "duration": "1:23",
    "time": "01:30 PM",
    "isMe": true,
    "readStatus": "sent",
    "audioUrl": "https://cdn.emr-app.com/uploads/chat/voice_12345.m4a"
  }
}
```

---

## 10. Zoom Video Call

### 10.1 Create Zoom Meeting

**`POST /zoom/meetings`**

#### Request Body

```json
{
  "topic": "Consultation with Dr. Michael Chen"
}
```

#### ✅ Success Response — `201 Created`

```json
{
  "status": "success",
  "data": {
    "id": "85264397812",
    "join_url": "https://zoom.us/j/85264397812",
    "password": "abc123",
    "is_simulated": false
  }
}
```

#### ⚠️ Fallback Response (Simulated) — `200 OK`

```json
{
  "status": "success",
  "data": {
    "id": "45632187654",
    "join_url": "https://zoom.us/j/45632187654",
    "password": "123",
    "is_simulated": true
  }
}
```

---

### 10.2 Get Zoom OAuth Token

**`POST /zoom/oauth/token`**

> ⚠️ **Note:** This is an internal server-to-server call. The client app should NOT call this directly in production.

#### ✅ Success Response — `200 OK`

```json
{
  "access_token": "eyJzdiI6IjAwMDAwMSIsImFsZyI6IkhTNTEyIiwidiI6IjIuMCIsImtpZCI6ImM0Y...",
  "token_type": "bearer",
  "expires_in": 3599,
  "scope": "meeting:write user:read"
}
```

#### ❌ Error Response — `401 Unauthorized`

```json
{
  "reason": "Invalid client_id or client_secret",
  "error": "invalid_client"
}
```

---

### 10.3 Get Zoom Session Details (for Video SDK)

**`GET /appointments/{appointmentId}/session-details`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": {
    "sessionName": "consultation_apt_2026_0315_001",
    "sessionPassword": "securePass123",
    "displayName": "Sarah Johnson",
    "roleType": "0",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "sessionTimeout": "40"
  }
}
```

---

### 10.4 Zoom SDK Init Config

> Used internally by `ZoomVideoSdkProvider`

```json
{
  "domain": "zoom.us",
  "enableLog": true
}
```

---

## 11. Settings

### 11.1 Get Settings

**`GET /settings`**

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "data": {
    "notificationsEnabled": true,
    "darkMode": false
  }
}
```

---

### 11.2 Update Notifications Setting

**`PATCH /settings/notifications`**

#### Request Body

```json
{
  "enabled": true
}
```

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "message": "Notification settings updated"
}
```

---

### 11.3 Update Dark Mode Setting

**`PATCH /settings/dark-mode`**

#### Request Body

```json
{
  "enabled": true
}
```

#### ✅ Success Response — `200 OK`

```json
{
  "status": "success",
  "message": "Dark mode settings updated"
}
```

---

## 12. Error Responses

### Standard Error Format

All API errors follow this consistent format:

```json
{
  "status": "error",
  "message": "Human-readable error message",
  "errorCode": "MACHINE_READABLE_CODE",
  "details": {}
}
```

### Common HTTP Status Codes

| Code  | Meaning                | When Used                                      |
|-------|------------------------|-------------------------------------------------|
| `200` | OK                     | Successful GET, PATCH, DELETE                   |
| `201` | Created                | Successful POST (resource created)              |
| `400` | Bad Request            | Malformed request body or missing parameters    |
| `401` | Unauthorized           | Invalid or expired token                        |
| `403` | Forbidden              | User lacks permission                           |
| `404` | Not Found              | Requested resource doesn't exist                |
| `422` | Unprocessable Entity   | Validation errors in request data               |
| `429` | Too Many Requests      | Rate limit exceeded                             |
| `500` | Internal Server Error  | Unexpected server-side failure                   |

### Common Error Examples

#### 401 — Token Expired

```json
{
  "status": "error",
  "message": "Your session has expired. Please login again.",
  "errorCode": "AUTH_TOKEN_EXPIRED"
}
```

#### 404 — Resource Not Found

```json
{
  "status": "error",
  "message": "The requested appointment was not found.",
  "errorCode": "RESOURCE_NOT_FOUND"
}
```

#### 429 — Rate Limit

```json
{
  "status": "error",
  "message": "Too many requests. Please try again after 60 seconds.",
  "errorCode": "RATE_LIMIT_EXCEEDED",
  "details": {
    "retryAfter": 60
  }
}
```

#### 500 — Server Error

```json
{
  "status": "error",
  "message": "An unexpected error occurred. Please try again later.",
  "errorCode": "INTERNAL_SERVER_ERROR"
}
```

---

## Data Models Summary

### Quick Reference Table

| Model               | Key Fields                                                                       |
|---------------------|----------------------------------------------------------------------------------|
| **Patient**         | `id`, `name`, `age`, `gender`, `avatar`, `personalInfo`, `vitals`, `medicalInfo` |
| **Appointment**     | `appointmentId`, `doctorName`, `date`, `time`, `priority`, `status`, `type`      |
| **Consultation**    | `id`, `doctor`, `appointment`, `status`, `bookingId`                             |
| **Prescription**    | `consultationId`, `doctorNotes`, `prescriptionSummary[]`, `attachments[]`        |
| **Medication**      | `id`, `name`, `type`, `dosage`, `schedule`, `instruction`, `duration`            |
| **Report**          | `id`, `title`, `date`, `doctor`, `type` (`lab`/`scan`), `pdfUrl`                |
| **Notification**    | `id`, `type`, `title`, `body`, `time`, `isRead`                                 |
| **Chat**            | `id`, `doctorName`, `lastMessage`, `time`, `hasUnread`                           |
| **Message**         | `id`, `type` (`text`/`image`/`file`/`voice`), `time`, `isMe`, `readStatus`      |
| **Zoom Meeting**    | `id`, `join_url`, `password`, `is_simulated`                                     |
| **Zoom Session**    | `sessionName`, `sessionPassword`, `displayName`, `roleType`, `token`             |

---

> **Note:** This document represents the **sample API structure** designed to match the current EMR App's data models and UI screens. The app currently uses local data (`SharedPreferences` and hardcoded mock data). When a backend is implemented, these are the expected API endpoints and response formats.
