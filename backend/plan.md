
## 👤 `/users`

### GET `/users`

```json id="users_v5"
[
  { "id": "u1", "name": "Dr. Smith" },
  { "id": "u2", "name": "Ms. Johnson" },
  { "id": "u3", "name": "Mr. Brown" },
  { "id": "u4", "name": "Leo" },
  { "id": "u5", "name": "Anna" }
]
```

---

# 🏫 `/classes`

## Data Model

```json id="classes_model_v5"
{
  "id": "c1",
  "name": "Mathematics 101",
  "desc": "Intro to algebra and calculus",
  "prof": {
    "id": "u1",
    "name": "Dr. Smith"
  },
  "schedule": {
    "dtstart": "2026-04-20T02:00:00Z",
    "dtend": "2026-04-20T03:30:00Z",
    "rrule": "FREQ=WEEKLY;BYDAY=MO,WE"
  },
  "location": "Room A201"
}
```

---

### GET `/classes`

```json id="classes_get_v5"
[
  {
    "id": "c1",
    "name": "Mathematics 101",
    "desc": "Intro to algebra and calculus",
    "prof": {
      "id": "u1",
      "name": "Dr. Smith"
    },
    "schedule": {
      "dtstart": "2026-04-20T02:00:00Z",
      "dtend": "2026-04-20T03:30:00Z",
      "rrule": "FREQ=WEEKLY;BYDAY=MO,WE"
    },
    "location": "Room A201"
  }
]
```

---

### POST `/classes`

```json id="classes_post_v5"
{
  "name": "Physics 101",
  "desc": "Basic mechanics",
  "prof": {
    "id": "u3",
    "name": "Mr. Brown"
  },
  "schedule": {
    "dtstart": "2026-04-22T02:00:00Z",
    "dtend": "2026-04-22T04:00:00Z",
    "rrule": "FREQ=WEEKLY;BYDAY=WE"
  },
  "location": "Room B101"
}
```

---

**Response**

```json id="classes_post_res_v5"
{
  "id": "c2",
  "name": "Physics 101",
  "desc": "Basic mechanics",
  "prof": {
    "id": "u3",
    "name": "Mr. Brown"
  },
  "schedule": {
    "dtstart": "2026-04-22T02:00:00Z",
    "dtend": "2026-04-22T04:00:00Z",
    "rrule": "FREQ=WEEKLY;BYDAY=WE"
  },
  "location": "Room B101"
}
```

---

# 📢 `/announcements`

### GET `/announcements`

```json id="announcements_v5"
[
  {
    "id": "a1",
    "title": "Midterms",
    "content": "Midterms start May 10"
  }
]
```

---

### POST `/announcements`

```json id="announcements_post_v5"
{
  "title": "Quiz Reminder",
  "content": "Short quiz tomorrow"
}
```

---

# 💬 `/chats`

---

### Data Model

```json id="chat_model_v5"
{
  "id": "chat1",
  "classId": "c1",
  "participants": [
    { "id": "u1", "name": "Dr. Smith" },
    { "id": "u4", "name": "Leo" }
  ],
  "messages": [
    {
      "time": "2026-04-20T02:00:00Z",
      "from": "u1",
      "message": "Have you started the assignment?"
    }
  ]
}
```

---

### POST `/chats`

```json id="chat_post_v5"
{
  "classId": "c1",
  "participants": [
    { "id": "u4", "name": "Leo" },
    { "id": "u5", "name": "Anna" }
  ]
}
```

---

### POST `/chats/:chatId/messages`

```json id="chat_msg_post_v5"
{
  "from": "u4",
  "message": "Are you coming to class?"
}
```

---

# 🍔 `/menu`

```json id="menu_v5"
[
  {
    "id": "m1",
    "name": "Fried Rice",
    "picture": "https://example.com/fried_rice.jpg",
    "price": 2.5,
    "qty": 50
  }
]
```

---

# 🧾 `/orders`

```json id="orders_post_v5"
{
  "userId": "u4",
  "items": [
    { "id": "m1", "qty": 2 }
  ],
  "extra_requests": "Less oil"
}
```
