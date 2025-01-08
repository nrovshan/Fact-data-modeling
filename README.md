# Fact-data-modeling

The project involves developing and maintaining a set of cumulative and incremental tables that track user and host activity. The overall objective is to create efficient structures and queries for monitoring user activity on different devices and hosts.

1. User Devices Cumulative Table (user_devices_cumulated):

This structure helps track user-device interactions over time, enabling analysis of device usage patterns and behavior.

2. Incremental Query for User Devices Activity:
   
This incremental approach ensures that the user_devices_cumulated table is updated with new interactions, while maintaining the history of device activity for users.

3.Device Activity Date Conversion (datelist_int):

Using integers for date activity can optimize storage and enable faster queries, especially when summarizing or aggregating user activity across different time periods.

4. Hosts Cumulative Table (hosts_cumulated):

This table aggregates the host-level activity, enabling monitoring of when a host was used and facilitating trend analysis across different hosts over time.

5. Incremental Query for Host Activity:

The incremental approach ensures that the host activity history remains up-to-date, providing insights into how frequently each host is used over time.

6. Host Activity Reduced Table (host_activity_reduced):

This summary table provides a more compact form of the host activity data, helping to track overall usage patterns, such as website traffic and user engagement, over time.

7. Incremental Query for Host Activity Reduction:

This query helps maintain an efficient summary of host activity by aggregating the raw event data into meaningful metrics. It also ensures that the activity is updated with each new day of data.
