MongoWSAT
=========

A pre-configured user administration section for ASP.NET websites (both MVC and WebForms) using MongoDB Membership and Role Providers.


Usage
-----

  1. Add MongoWSAT to your web project (MVC or WebForms) using Nuget
  2. Add relevant sections from 'example_web.config' and 'example_global.asax' files
  3. Point browser to 'Users/Default.aspx' and follow instructions to create the default admin account and role


Motivation
----------

Provide a quick way to administer users for ASP.NET websites (both MVC and WebForms) which use MongoDB rather than Sql Server.

ASP.NET MVC sites can use ASP.NET pages without issue so Hunzonian's [MyWSAT][1] offers a great way to get up and running quickly. But MyWSAT is closely tied to SQL Server.  
This project is a port of an older version of the MyWSAT Starter Kit which was not so closely tied to Sql Server.

Converting this project to use a NoSQL data store other than Mongo should be fairly straightforward.  The only place that explicitly relies on Mongo now is the WebProfile class.

[1]: http://mywsat.codeplex.com/ "MyWSAT Website Starter Kit"


License
-------

  LGPL - The WSAT code is largely unchanged from Hunzonian's earlier version and retains the original LGPL license.


Dependencies
------------

All dependencies are included.

* MongoProviders - https://github.com/alanning/MongoProviders
* AjaxControlToolkit - NuGet
* FluentMongo - NuGet
* Mongo Csharp Drivers - NuGet


Conventions
-----------

* The WebProfile class inherits from MongoProviders.User and saves its data into the same collection the MembershipProvider uses to save User data.
* The MembershipProvider and RoleProvider are optimized for Mongo and combine the ApplicationName into the CollectionName.  This saves us from having to include the ApplicationName in every query and also relieves us from having to include ApplicationName in the indexes. To query the collections from the Mongo Interactive Shell, run queries like so:  
`> db['/users'].find()`
* The RoleProvider stores all roles as lowercase.  This is done to prevent someone from creating an "Administrator" role while someone else creates an "administrator" role.


Changes from MyWSAT
-------------------

1. Use Mongo Membership and Role Providers
   <insert config sections>

2. Replace FCKEditor with Ajax Control Toolkit Html Editor Extender

3. Change membership provider name to non-sql name (WSATSqlMembershipProviderAdmin -> MembershipProviderAdmin)

4. Enable usage of Hashed passwords.  MyWSAT assumes password retrieval is enabled which is not possible with hashed passwords.

5. Convert from using Profile Provider to using serialized class

6. Convert from using Membership.xsd table adapter to using Membership provider

7. Make Dashboard default to showing Users by Name

8. Remove usage of database for storing SMTP server and email From addresses in Quick_contact.aspx.cs
