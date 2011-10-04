MongoWSAT
=========

A pre-configured user administration section for ASP.NET websites (both MVC and WebForms) using MongoDB Membership and Role Providers.  
(Requires .NET Framework 4.0)


Usage
-----

  1. Make sure your project is targetting the .NET 4.0 Framework
  2. Add MongoWSAT to your web project (MVC or WebForms) using Nuget.  In addition to the referenced DLLs, the following files and folders will be added to your project:
	 * Users/
	 * exampleConfigs/
	 * App_Themes
	 * Site.master
	 * MongoWSAT-README.md
  3. Modify web.config and global.asax using the files in exampleConfigs/ as a guide
  4. Point browser to 'Users/' and follow the instructions to set up admin and test users.
  5. Decide whether to use Members/MyAccountInfo.aspx page for User self-management of Password, Profile, and Email.  If not, remove the Members/* pages.
  6. Decide whether to use Login.aspx, Register.aspx, and RecoverPassword.aspx.  Remove if unused.
     

Motivation
----------

Provide a quick way to administer users for ASP.NET websites (both MVC and WebForms) which use MongoDB rather than Sql Server.

Hunzonian's [MyWSAT][1] project offers a great way to get up and running quickly with user administration but MyWSAT is closely tied to SQL Server.  
MongoWSAT is a port of an older version of the MyWSAT Starter Kit which was not so dependent on Sql Server and therefore easier to convert.  See below for a list of changes made.

Using a NoSQL data store other than Mongo should be fairly straightforward.  Just modify WebProfile to save to your datastore of choice and switch out the Membership and Role providers in web.config.

[1]: http://mywsat.codeplex.com/ "MyWSAT Website Starter Kit"


License
-------

  LGPL - The WSAT code is largely unchanged from Hunzonian's earlier version and retains the original LGPL license.


Dependencies
------------

(Requires .NET Framework 4.0)
All dependencies are included in the lib folder rather than using Nuget packages in order to save space and make the install quicker.

* MongoProviders - https://github.com/alanning/MongoProviders
* AjaxControlToolkit - http://ajaxcontroltoolkit.codeplex.com/
* FluentMongo - https://github.com/craiggwilson/fluent-mongo
* Mongo Csharp Drivers - https://github.com/mongodb/mongo-csharp-driver


Notes
-----

* The WebProfile class inherits from MongoProviders.User and saves its data into the same collection the MembershipProvider uses to save User data.
* The MembershipProvider and RoleProvider are optimized for Mongo and combine the ApplicationName into the CollectionName.  This saves us from having to include the ApplicationName in every query and also relieves us from having to include ApplicationName in the indexes. To query the collections from the Mongo Interactive Shell, run queries like so:  
`> db['/users'].find()`
* The RoleProvider stores all roles as lowercase.  This is done to prevent someone from creating an "Administrator" role while someone else creates an "administrator" role.
* Login, Register, ChangePassword, RetrievePassword can all be done using either MVC or WebForms. But MVC and WebForms pages can not share masterpages so make sure to make them match if mixing.
* Users/Register.aspx uses email verification to 'activate' new users.


Changes from MyWSAT
-------------------

1. Use Mongo Membership and Role Providers
   <insert config sections>

2. Replace FCKEditor with Ajax Control Toolkit Html Editor Extender

3. Change membership provider name to non-sql name (WSATSqlMembershipProviderAdmin -> MembershipProviderAdmin)

4. Enable usage of Hashed passwords.  MyWSAT assumes password retrieval is enabled which is not possible with hashed passwords.

5. Convert from using Profile Provider to using serialized class (WebProfile)

6. Convert from using Membership.xsd table adapter to using Membership provider

7. Make Dashboard default to showing Users by Name

8. Remove usage of database for storing SMTP server and email From addresses in Quick_contact.aspx.cs


Troubleshooting
---------------

* Problem: Building solution gives Mongo 'missing reference' errors
  Reason: This occurs because the project is not targetting the .NET 4 Framework.  MongoWSAT requires .NET 4.0 and the Nuget package knows this so it won't add references to the required DLLs if the project isn't targetting 4.0.  Unfortunately there is no way that I know of to specify that an entire Nuget package requires 4.0.
  Resolution: Change the project to target the .NET 4 Framework (under the project properties, application tab).
