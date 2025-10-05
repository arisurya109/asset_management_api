# Asset Management API 

## Tech Stack
- **Backend:** Dart Frog
- **Database:** MYSQL
- **Language:** Dart
- **Authentication:** JWT (JSON Web Token)

---

## Setup & Installation

### 1. Clone Repository
```bash
git clone https://github.com/username/asset_management_api.git
cd asset_management_api
```
### 2. Install Dependencies / Package
```bash
dart pub get
```

### 3. Setup Database
```bash
CREATE DATABASE asset_management_api
```

### 4. Configure Environment
.env di root folder :
```bash
# Secret key untuk JWT
SECRET_KEY= ''

# Konfigurasi Database
DB_HOST=''
DB_USER=''
DB_PASSWORD=''
DB_NAME=''
DB_PORT=''
```

### 5. Run Server
```bash
dart_frog dev
```

----

# API Documentation
- **Login**
- **Change Password**
- **User**
- **Asset**
- **Brands**
- **Asset Types**

----
## Login

**POST** ```/api/login```

Login User to Sistem

**REQUEST JSON**
```JSON
{
    "username" : "TESTING",
    "password" : "New Password"
}
```

**RESPONSE JSON**
```JSON
{
    "status": "Ok",
    "token": "ehbGciOiJIUzI1NiIsInR5cCI6IkpXeyJpZCI6MSwiaWF0IjoIyNzAzLCJleHAi",
    "data": {
        "id": 1,
        "username": "TESTING",
        "name": "TESTING1",
        "modules": [
            "ASSET MASTER_CREATE",
            "ASSET MASTER_READ",
            "ASSET MASTER_UPDATE",
            "ASSET MASTER_DELETE"
        ]
    }
}
```

---

## Change Password

**PUT** ```/api/change_password```

Change password user, after user login to sistem

**REQUEST JSON**
```JSON
{
    "username" : "username",
    "old_password" : "Old Password",
    "new_password" : "New Password"
}
```

**RESPONSE JSON**
```JSON
{
    "status": "Successfully change password, please re-login"
}
```

---

## Create User

**POST** ```/api/user```

**REQUEST JSON**
```JSON
{
    "username" : "Testing6",
    "password" : "Testing6",
    "name" : "Testing6",
    "created_by" : "TESTING",
    "modules" : [
        {"module_id" : 1, "permission_id" : 1},
        {"module_id" : 1, "permission_id" : 2},
        {"module_id" : 1, "permission_id" : 3},
        {"module_id" : 1, "permission_id" : 4}
    ]
}
```

**RESPONSE JSON**
```JSON
{
    "status": "Successfully created new user",
    "data": {
        "id": 9,
        "username": "Testing6",
        "name": "Testing6",
        "is_active": 1,
        "created_at": "2025-10-05T07:10:23.000Z"
    }
}
```

---

## Get All User

**GET** ```/api/user```

**RESPONSE JSON**
```JSON
{
    "status": "Successfully get all user",
    "data": [
        {
            "id": 4,
            "username": "TESTING2",
            "name": "TESTING2",
            "is_active": 1,
            "created_at": "2025-10-04T02:29:25.000Z"
        },
        {
            "id": 6,
            "username": "Testing3",
            "name": "Testing3",
            "is_active": 1,
            "created_at": "2025-10-04T20:32:58.000Z"
        }
    ]
}
```

---

## Get User By Id

**GET** ```/api/user/:id```

**RESPONSE JSON**
```JSON
{
    "status": "Successfully get user",
    "data": {
        "id": 4,
        "username": "TESTING2",
        "name": "TESTING2",
        "is_active": 1,
        "created_at": "2025-10-04T02:29:25.000Z"
    }
}
```

---

## Update Status User

**PUT** ```/api/user/:id```

**REQUEST JSON**
```JSON
{
    "is_active" : 0
}
```

**RESPONSE JSON**
```JSON
{
    "status": "Successfully update status user",
    "data": {
        "id": 4,
        "username": "TESTING2",
        "name": "TESTING2",
        "is_active": 0,
        "created_at": "2025-10-04T02:29:25.000Z"
    }
}
```

---

## Reset Password

**PATCH** ```/api/user/:id```

Reset Password User By Admin or User Access Privilege

**REQUEST JSON**
```JSON
{
   "password" : "Change Password By Admin"
}
```

**RESPONSE JSON**
```JSON
{
    "status": "Successfully update user",
    "data": {
        "id": 4,
        "username": "TESTING2",
        "name": "TESTING2",
        "is_active": 0,
        "created_at": "2025-10-04T02:29:25.000Z"
    }
}
```

---

## Get All Asset

**GET** ```/api/asset```

**RESPONSE JSON**
```JSON
{
    "status": "Successfully get all asset",
    "data": [
        {
            "id": 1,
            "asset_code": "D0001",
            "asset_name": "DESKTOP STAND",
            "asset_init": "DS"
        },
        {
            "id": 2,
            "asset_code": "D0002",
            "asset_name": "PRINTER",
            "asset_init": "PRN"
        }
    ]
}
```

---

## Get Asset By Id

**GET** ```/api/asset/:id```

**RESPONSE JSON**

```JSON
{
    "status": "Successfully get asset",
    "data": {
        "id": 1,
        "asset_code": "D0001",
        "asset_name": "DESKTOP STAND",
        "asset_init": "DS"
    }
}
```
---

## Create Asset

**POST** ```/api/asset```

**REQUEST JSON**

```JSON
{
    "asset_name" : "Monitor",
    "asset_init" : "MN"
}
```

**RESPONSE JSON**

```JSON
{
    "status": "Successfully create new asset",
    "data": {
        "id": 3,
        "asset_code": "D0003",
        "asset_name": "MONITOR",
        "asset_init": "MN"
    }
}
```
---

## Update Asset

**PUT** ```/api/asset```

**REQUEST JSON**

```JSON
{
    "asset_name" : "Monitor Update"
}
```

**RESPONSE JSON**

```JSON
{
    "status": "Successfully update asset",
    "data": {
        "id": 3,
        "asset_code": "D0003",
        "asset_name": "MONITOR UPDATE",
        "asset_init": "MN"
    }
}
```
---

## Create Brand

**POST** ```/api/brand```

**REQUEST JSON**

```JSON
{
    "brand_code" : "DL",
    "brand_name" : "Dell",
    "asset" : {
        "id" : 3,
        "name" : "MONITOR UPDATE"
    }
}
```

**RESPONSE JSON**

```JSON
{
    "status": "Successfully create new brand",
    "data": {
        "id": 2,
        "brand_code": "DL",
        "brand_name": "Dell",
        "asset": {
            "id": 3,
            "name": "MONITOR UPDATE"
        }
    }
}
```
---

## Get All Brand

**GET** ```/api/brand```

**RESPONSE JSON**

```JSON
{
    "status": "Successfully get all brand",
    "data": [
        {
            "id": 1,
            "brand_code": "CN",
            "brand_name": "Canon",
            "asset": {
                "id": 2,
                "name": "PRINTER"
            }
        },
        {
            "id": 2,
            "brand_code": "DL",
            "brand_name": "Dell",
            "asset": {
                "id": 3,
                "name": "MONITOR UPDATE"
            }
        }
    ]
}
```
---

## Get By Id Brand

**GET** ```/api/brand/:id```

**RESPONSE JSON**

```JSON
{
    "status": "Successfully get brand by id",
    "data": {
        "id": 1,
        "brand_code": "CN",
        "brand_name": "Canon",
        "asset": {
            "id": 2,
            "name": "PRINTER"
        }
    }
}
```
---

## Update Brand

**PUT** ```/api/brand/:id```

**REQUEST JSON**

```JSON
{
    "brand_code" : "CN",
    "brand_name" : "Canon Update",
    "asset" : {
        "id" : 2,
        "name" : "PRINTER"
    }
}
```

**RESPONSE JSON**

```JSON
{
    "status": "Successfully update brand",
    "data": {
        "id": 1,
        "brand_code": "CN",
        "brand_name": "Canon Update",
        "asset": {
            "id": 2,
            "name": "PRINTER"
        }
    }
}
```
---

## Create Type

**POST** ```/api/asset_type```

**REQUEST JSON**

```JSON
{
    "type_name" : "MF3010",
    "brand" : {
        "id" : 1,
        "name" : "Canon Update"
    }
}
```

**RESPONSE JSON**

```JSON
{
    "status": "Successfully create new asset type",
    "data": {
        "id": 1,
        "type_name": "MF3010",
        "brand": {
            "id": 1,
            "name": "Canon Update"
        }
    }
}
```
---

## Get All Type

**GET** ```/api/asset_type```

**RESPONSE JSON**

```JSON
{
    "status": "Successfully get all asset type",
    "data": [
        {
            "id": 1,
            "type_name": "MF3010",
            "brand": {
                "id": 1,
                "name": "Canon Update"
            }
        }
    ]
}
```
---


## Get Type By Id

**GET** ```/api/asset_type/:id```

**RESPONSE JSON**

```JSON
{
    "status": "Successfully get asset type",
    "data": {
        "id": 1,
        "type_name": "MF3010",
        "brand": {
            "id": 1,
            "name": "Canon Update"
        }
    }
}
```
---

## Update Asset Type

**PUT** ```/api/asset_type/:id```

**REQUEST JSON**

```JSON
{
    "type_name" : "MF3010 Update",
    "brand" : {
        "id" : 1,
        "name" : "Canon Update"
    }
}
```

**RESPONSE JSON**

```JSON
{
    "status": "Successfully update asset type",
    "data": {
        "id": 1,
        "type_name": "MF3010 Update",
        "brand": {
            "id": 1,
            "name": "Canon Update"
        }
    }
}
```
---