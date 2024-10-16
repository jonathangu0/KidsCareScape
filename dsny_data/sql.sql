/*
drop table dsny;
create table dsny (
Unique_Key varchar(255),
Created_Date timestamp without time zone,
Closed_Date timestamp without time zone,
Agency varchar(255),
Agency_Name varchar(255),
Complaint_Type varchar(255),
Descriptors  text,
Location_Type  varchar(255),
Incident_Zip varchar(255),
Incident_Address varchar(255),
Street_Name varchar(255),
Cross_Street_1 varchar(255),
Cross_Street_2 varchar(255),
Intersection_Street_1 varchar(255),
Intersection_Street_2 varchar(255),
Address_Type varchar(255),
City varchar(255),
Landmark varchar(255),
Facility_Type varchar(255),
Status varchar(255),
Due_Date timestamp without time zone,
Resolution_Description text,
Resolution_Action_Updated_Date timestamp without time zone,
Community_Board varchar(255),
BBL varchar(255),
Borough varchar(255),
X_Coordinate_State_Plane decimal,
Y_Coordinate_State_Plane decimal,
Open_Data_Channel_Type varchar(255),
Park_Facility_Name varchar(255),
Park_Borough varchar(255),
Vehicle_Type varchar(255),
Taxi_Company_Borough varchar(255),
Taxi_Pick_Up_Location varchar(255),
Bridge_Highway_Name varchar(255),
Bridge_Highway_Direction varchar(255),
Road_Ramp varchar(255),
Bridge_Highway_Segment varchar(255),
Latitude decimal,
Longitude decimal,
Location  varchar(255)



)
;
*/
/*
copy dsny from
'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsny.csv' header csv delimiter ','
*/
-- select distinct status from dsny
--select distinct complaint_type, descriptors from dsny where complaint_type like 'Missed Co%'
-- select * from dsny limit 10
-- copy (select distinct complaint_type from dsny) to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsnyComplaintType.csv' header csv delimiter ','
/*
drop table dsny_new;
select unique_key, extract(year from created_date) as year, extract(month from created_date) as month, extract(day from created_date) as day, 
created_date, closed_date, (extract(EPOCH from cast((closed_date - created_date) as interval))/60/60/24)::integer as number_of_days_to_close,
case when closed_date is  null then (extract(EPOCH from cast((current_date - created_date) as interval))/60/60/24)::integer end as duration,
case when closed_date is  null then (extract(EPOCH from cast((current_date - due_date) as interval))/60/60/24)::integer end as number_of_past_due_days,
case when complaint_type = 'Dirty Condition' then 'Dirty Conditions' when complaint_type = 'Electronics Waste Appointment' then 'Electronics Waste'
when complaint_type like 'Litter Basket%' then 'Litter Basket Complaint' when complaint_type like '%Snow%' then 'snow'when complaint_type like '%Sweeping%' then 'Sweeping Complaint'
when complaint_type like 'Missed Coll%' then 'Missed Collection'

else complaint_type end as complaint_type, 
Descriptors,
location_type, incident_zip as zip, incident_address as adress,  city, facility_type, status, case when closed_date is not null then 'Closed' else 'Open' end as status_cal, 
due_date,
case when community_board  ~ '^[0-9]' and community_board like '%MANHATTAN%' then '1'||left(community_board, 2)
     when community_board  ~ '^[0-9]' and community_board like '%BRONX%' then '2'||left(community_board, 2)
	 when community_board  ~ '^[0-9]' and community_board like '%BROOKLYN%' then '3'||left(community_board, 2)
	 when community_board  ~ '^[0-9]' and community_board like '%QUEENS%' then '4'||left(community_board, 2)
	 when community_board  ~ '^[0-9]' and community_board like '%STATEN ISLAND%' then '5'||left(community_board, 2)
	 end as community_board,
	 
borough, 
	 latitude, longitude, location
into dsny_new
from dsny
*/
-- select * from dsny_new limit 1000
-- select count(*) from dsny_new
/*
copy (
select * from dsny_new 
	) 
	to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsny_new.csv' header csv delimiter ','
	*/
	/*
copy (
select year, borough, community_board, complaint_type, descriptors, status_cal, count(*), avg(duration), avg(number_of_past_due_days), avg(number_of_days_to_close) from dsny_new
group by year, borough, community_board, complaint_type, descriptors, status_cal order by 1,2,3,4,6)
 to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsnySummary_year_bor_comm_comtype_desc_status.csv' header csv delimiter ','
 */
 /*
 copy (
select year, borough, community_board, complaint_type, status_cal, count(*), avg(duration), avg(number_of_past_due_days), avg(number_of_days_to_close) from dsny_new
group by year, borough, community_board, complaint_type,  status_cal order by 1,2,3,4)
 to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsnySummary_year_bor_comm_comtype_status.csv' header csv delimiter ','
 */
 /*
 copy (
select year, borough, complaint_type, status_cal, count(*), avg(duration), avg(number_of_past_due_days), avg(number_of_days_to_close) from dsny_new
group by year, borough,  complaint_type, status_cal order by 1,2,3,4)
 to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsnySummary_year_bor_comtype_status.csv' header csv delimiter ','
 */
 /*
 copy (
select year, complaint_type,  status_cal, count(*), avg(duration), avg(number_of_past_due_days), avg(number_of_days_to_close) from dsny_new
group by year,  complaint_type, status_cal order by 1,2,3)
 to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsnySummary_year_comtype_status.csv' header csv delimiter ','
 */
 /*
 copy (
select year, status_cal, count(*), avg(duration), avg(number_of_past_due_days), avg(number_of_days_to_close) from dsny_new
group by year, status_cal order by 1,2)
 to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsnySummary_status.csv' header csv delimiter ','
 */
 /*
 copy (
select year, count(*), avg(duration), avg(number_of_past_due_days), avg(number_of_days_to_close) from dsny_new
group by year order by 1)
 to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsnySummary_year.csv' header csv delimiter ','
 */
 /*
 copy (
select year, borough, community_board, count(*), avg(duration), avg(number_of_past_due_days), avg(number_of_days_to_close) from dsny_new
group by year, borough, community_board order by 1,2,3)
 to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsnySummary_year_bor_comm.csv' header csv delimiter ','
 */
 /*
 copy (
select year, borough, count(*), avg(duration), avg(number_of_past_due_days), avg(number_of_days_to_close) from dsny_new
group by year, borough order by 1,2)
 to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsnySummary_year_bor.csv' header csv delimiter ','
 */
/* 
 copy (
select  complaint_type,   count(*), avg(duration), avg(number_of_past_due_days), avg(number_of_days_to_close) from dsny_new
group by  complaint_type order by 1)
 to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsnySummary_comtype.csv' header csv delimiter ','
 */
 /*
copy (
select * from dsny_new where year >=2020
	) 
	to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsny_new_2020.csv' header csv delimiter ','
	*/
/* 
 copy (
select  year, complaint_type,   count(*), avg(duration), avg(number_of_past_due_days), avg(number_of_days_to_close) from dsny_new
group by year, complaint_type order by 1,2)
 to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsnySummary_year_comtype.csv' header csv delimiter ','
 */
 /*
 copy (
select *, case when complaint_type not in ('Dirty Conditions','Missed Collection',
'Sanitation Condition','Derelict Vehicles') then 'Other'
else complaint_type end as complaint_type_cal


from dsny_new where year = 2020 and status_cal = 'Open'
	) 
	to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsny_new_2020_only_open.csv' header csv delimiter ','
*/
 /*
 copy (
select *,case when complaint_type not in ('Dirty Conditions','Missed Collection',
'Sanitation Condition','Derelict Vehicles') then 'Other'
else complaint_type end as complaint_type_cal from dsny_new where year = 2021 and status_cal = 'Open'
	) 
	to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsny_new_2021_only_open.csv' header csv delimiter ','
*/

 /*
 copy (
select *,case when complaint_type not in ('Dirty Conditions','Missed Collection',
'Sanitation Condition','Derelict Vehicles') then 'Other'
else complaint_type end as complaint_type_cal from dsny_new where year = 2022
	) 
	to 'C:\Users\fguo\Documents\work\ad-hoc\20220504dsny\dsny_new_2022_only.csv' header csv delimiter ','
*/



 
 
 