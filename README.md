Problem Statement
At SmartFab Industries, our production teams currently rely on paper logs and ad-hoc
spreadsheets to record raw material usage, compute manufacturing costs, and set selling prices,
leading to stock discrepancies, cost-overruns, and slow, error-prone reporting. To streamline
operations and boost profitability, we need a Flutter-based Material Tracking & Costing
App that enforces role-based access, captures real-time consumption via QR/barcode
scanning, automates all cost calculations, and keeps inventory and cost histories in sync across
devices and the cloud. The app must let Admins manage materials, processes, users, and view
analytics, while Operators can only scan materials, log usage, and see assigned tasks. It should
work offline—caching scans and logs locally—and reconcile seamlessly with Firebase (or
similar) once online. Your task is to deliver a working prototype that addresses these
challenges while following Flutter best practices for state management, offline persistence,
and secure data handling.
Key Pain Points to Solve:
 Manual material logging causing stock mismatches and lost data.
 Time-consuming, error-prone cost and price calculations.
 Lack of role segregation leading to unauthorized edits or data leaks.
 Delayed visibility into low-stock alerts and cost overruns.
The ideal solution will balance performance, usability, and security while demonstrating
clean, well-structured, and maintainable code.
Note:
 Role-Based Access Control (RBAC):
o Admin: Add/Edit/Delete materials, processes, users; view dashboards, analytics,
and exportable reports.
o Operator: Scan materials, log consumption, and view only assigned operations.
 Real-Time Material Tracking:
o Scan QR/barcodes to auto-fetch material details (name, unit cost, unit type,
stock).
o Offline caching of scans/logs in Hive or SQLite; sync changes on reconnection.
 Automated Cost Calculations:
o Raw Material Cost = Unit Cost × Quantity Used
o Manufacturing Cost = Raw Material Cost + Additional Processing Costs (labor,
energy, etc.)
o Final Product Price = Manufacturing Cost + Desired Margin
o Suggested Selling Price and Profit Margin computed per unit.
 Inventory Management:
o Real-time stock level updates on each consumption log.
o Low-stock alert notifications for Admins.
o Maintains a searchable history of consumption by date, material, and product.
 Reporting & Exports:
o Cost breakdown reports (raw material, processing, selling) viewable by Admin.
o Export logs and summaries as PDF or CSV for further analysis.
 Data Storage & Sync:
o Local persistence (Hive/SQLite) for instant access and offline use.
o Cloud sync (e.g., Firebase Firestore) for backup, multi-device consistency, and
real-time updates.
