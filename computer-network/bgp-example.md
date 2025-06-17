---
title: BGP Example
---

### 🗺️ **Network Topology Example**

We have 4 Autonomous Systems (ASes):

```
+-------+        +-------+        +-------+        +-------+
| AS 100| <----> | AS 200| <----> | AS 300| <----> | AS 400|
+-------+        +-------+        +-------+        +-------+
```

Let’s say:

* **AS 400** originates a route to network **10.0.0.0/24**
* It announces:

  ```
  "To reach 10.0.0.0/24, go through [AS400]"
  ```

---

### 🔁 **How the Path Vector Propagates**

1. **AS 300 receives it** and appends its own AS:

   ```
   "10.0.0.0/24 via [AS300, AS400]"
   ```

2. **AS 200 receives it**:

   ```
   "10.0.0.0/24 via [AS200, AS300, AS400]"
   ```

3. **AS 100 receives it**:

   ```
   "10.0.0.0/24 via [AS100, AS200, AS300, AS400]"
   ```

---

### 🔁 **What If a Loop Tries to Form?**

Let’s say now **AS 400** receives the same route **back** from AS 100.
That route would look like:

```
"10.0.0.0/24 via [AS100, AS200, AS300, AS400]"
```

🛑 But AS 400 **sees its own AS number (AS400)** in the path.

✅ So it **rejects** the route — **loop avoided!**

---

### 🧠 **Why This Works**

* The path vector protocol includes the entire **route history** (AS\_PATH).
* A router can **look at the path** and **detect loops** before they happen.
* Unlike RIP (which might loop until hop count hits 16), BGP can **instantly discard** bad routes.

---

### ✅ Summary: How Path Vector Prevents Loops

| Mechanism                  | Description                                                      |
| -------------------------- | ---------------------------------------------------------------- |
| **AS\_PATH**               | Route includes all ASes the advertisement has passed through     |
| **Loop Detection**         | If a router sees its own AS in the AS\_PATH → **DROP the route** |
| **Safe Route Propagation** | Only loop-free, policy-compliant routes are advertised           |

---
