# Event-pro

A Java web application for event management system.

## Description

Event-pro is a comprehensive event management platform built with Java servlets, JSP, and MySQL. It provides functionalities for administrators, organizers, and users to manage events, bookings, services, packages, teams, venues, and handle complaints.

## Features

- **Admin Dashboard**: Manage users, packages, services, teams, venues, and view bookings and complaints.
- **User Management**: Create, update, and manage user accounts.
- **Package Management**: Create and manage event packages.
- **Service Management**: Add and manage various services for events.
- **Team Management**: Organize and manage event teams.
- **Venue Management**: Handle venue details and availability.
- **Booking System**: Manage event bookings.
- **Complaint Handling**: Track and resolve user complaints.

## Technologies Used

- **Backend**: Java, Servlets, JSP
- **Database**: MySQL
- **Frontend**: HTML, CSS, JavaScript
- **Build Tool**: Maven (assumed based on structure)
- **Server**: Apache Tomcat (recommended)

## Prerequisites

- Java JDK 8 or higher
- Apache Tomcat 9 or higher
- MySQL Server
- Maven (if using Maven for build)

## Installation and Setup

1. **Clone the repository**:

   ```
   git clone https://github.com/sivamsansiva/Event-pro.git
   cd Event-pro
   ```

2. **Database Setup**:

   - Import the `src/main/event_management.sql` file into your MySQL database.
   - Update database connection details in `src/main/java/util/DatabaseConnection.java`.

3. **Build the project**:

   - If using Maven: `mvn clean compile`
   - Or use your IDE's build functionality.

4. **Deploy to Tomcat**:

   - Copy the WAR file or the webapp folder to Tomcat's webapps directory.
   - Start Tomcat server.

5. **Access the application**:
   - Open your browser and go to `http://localhost:8080/Event-pro`

## Project Structure

- `src/main/java/controller/`: Servlet controllers
- `src/main/java/dao/`: Data Access Objects
- `src/main/java/model/`: Model classes
- `src/main/java/util/`: Utility classes
- `src/main/webapp/`: JSP pages and web resources
- `src/main/event_management.sql`: Database schema

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
