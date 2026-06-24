@echo off
echo ========================================================
echo   Smart Medical Supply Management System (SMSMS)
echo   Database Initialization Script
echo ========================================================
echo.
echo Please ensure your local MySQL server is running.
echo.

set /p user="Enter your MySQL Username (e.g., root): "
set /p pass="Enter your MySQL Password: "

echo.
echo [1/5] Creating Database Schema...
mysql -u %user% -p%pass% < schema.sql

echo [2/5] Inserting Sample Data...
mysql -u %user% -p%pass% < sample_data.sql

echo [3/5] Creating Stored Procedures...
mysql -u %user% -p%pass% < stored_procedures.sql

echo [4/5] Creating Triggers...
mysql -u %user% -p%pass% < triggers.sql

echo [5/5] Creating Views...
mysql -u %user% -p%pass% < views.sql

echo.
echo ========================================================
echo SUCCESS! The SMSMS Project database is now fully running.
echo You can now open MySQL Workbench or phpMyAdmin to view it.
echo ========================================================
pause
