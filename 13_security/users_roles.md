# Security: Users, Roles & Privileges

## 📌 Concept
Database security controls who can access what data and perform what operations through users, roles, and privileges.

## 🧾 Key Objects

| Object | Purpose |
|--------|---------|
| User | Individual account with login |
| Role | Group of related privileges |
| Object Privilege | Access to specific table/procedure |
| System Privilege | System-level operations (CREATE TABLE, etc.) |

## ✅ Examples

### Create User
```sql
-- Create user with password
CREATE USER john_user IDENTIFIED BY password123;

-- Grant basic privileges
GRANT CREATE SESSION TO john_user;

-- Grant quota on tablespace
ALTER USER john_user QUOTA 100M ON users;
```

### Create Role
```sql
-- Create role
CREATE ROLE analyst_role;

-- Grant privileges to role
GRANT SELECT, INSERT, UPDATE ON employees TO analyst_role;
GRANT analyst_role TO john_user;
```

### Grant Privileges
```sql
-- Object privilege (specific table)
GRANT SELECT, INSERT, UPDATE ON employees TO john_user;

-- System privilege (any table)
GRANT SELECT ON ANY TABLE TO john_user;

-- All privileges on schema
GRANT ALL PRIVILEGES ON hr.* TO john_user;
```

### Revoke Privileges
```sql
REVOKE INSERT ON employees FROM john_user;
REVOKE analyst_role FROM john_user;
```

### View Data Dictionary
```sql
-- Users
SELECT * FROM dba_users;

-- Roles
SELECT * FROM dba_roles;

-- User privileges
SELECT * FROM user_sys_privs;
SELECT * FROM user_tab_privs;

-- What user has
SELECT * FROM role_sys_privs;
```

## ⚠️ Common Mistakes

- Granting excessive privileges
- Not revoking old user access
- Role for security vs convenience mixing
- Forgetting minimum passwordrequirements
- Exposing password in script

## 💡 Tips

- Principle of least privilege: grant only needed
- Use roles to manage group privileges
- Regular audit of who has what
- Separate application users from admin
- Use PUBLIC role sparingly
- Always revoke when job changes
