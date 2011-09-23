// Copyright (c) 2004-2008 MySQL AB, 2008-2009 Sun Microsystems, Inc.
//
// MySQL Connector/NET is licensed under the terms of the GPLv2
// <http://www.gnu.org/licenses/old-licenses/gpl-2.0.html>, like most 
// MySQL Connectors. There are special exceptions to the terms and 
// conditions of the GPLv2 as it is applied to this software, see the 
// FLOSS License Exception
// <http://www.mysql.com/about/legal/licensing/foss-exception.html>.
//
// This program is free software; you can redistribute it and/or modify 
// it under the terms of the GNU General Public License as published 
// by the Free Software Foundation; version 2 of the License.
//
// This program is distributed in the hope that it will be useful, but 
// WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
// or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
// for more details.
//
// You should have received a copy of the GNU General Public License along 
// with this program; if not, write to the Free Software Foundation, Inc., 
// 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA

//  This code was contributed by Sean Wright (srwright@alcor.concordia.ca) on 2007-01-12
//  The copyright was assigned and transferred under the terms of
//  the MySQL Contributor License Agreement (CLA)

using NUnit.Framework;
using System;
using System.Linq;
using System.Web.Security;
using System.Collections.Specialized;
using System.Configuration.Provider;
using MongoProviders;

namespace MongoProviders.UnitTests
{
    
    /// <summary>
    ///This is a test class for RoleProviderTest and is intended
    ///to contain all RoleProviderTest Unit Tests
    ///</summary>
    [TestFixture]
    public class RoleProviderTest : BaseTest
    {

        private MongoProviders.MembershipProvider membershipProvider;
        private MongoProviders.RoleProvider roleProvider;

        [SetUp]
		public override void Setup()
		{
			base.Setup();


			membershipProvider = new MongoProviders.MembershipProvider();
			NameValueCollection config = new NameValueCollection();
			config.Add("connectionStringName", "local");
			config.Add("applicationName", _applicationName);
			membershipProvider.Initialize(null, config);

            roleProvider = new RoleProvider();
            config = new NameValueCollection();
			config.Add("connectionStringName", "local");
			config.Add("applicationName", _applicationName);
			roleProvider.Initialize(null, config);
		}


        /*

        [TestMethod()]
        public void FindUsersInRoleTest()
        {
            RoleProvider target = new RoleProvider(); // TODO: Initialize to an appropriate value
            string roleName = string.Empty; // TODO: Initialize to an appropriate value
            string usernameToMatch = string.Empty; // TODO: Initialize to an appropriate value
            string[] expected = null; // TODO: Initialize to an appropriate value
            string[] actual;
            actual = target.FindUsersInRole(roleName, usernameToMatch);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }


        [TestMethod()]
        public void GetUsersInRoleTest()
        {
            RoleProvider target = new RoleProvider(); // TODO: Initialize to an appropriate value
            string roleName = string.Empty; // TODO: Initialize to an appropriate value
            string[] expected = null; // TODO: Initialize to an appropriate value
            string[] actual;
            actual = target.GetUsersInRole(roleName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }



        [TestMethod()]
        public void RoleExistsTest()
        {
            RoleProvider target = new RoleProvider(); // TODO: Initialize to an appropriate value
            string roleName = string.Empty; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = target.RoleExists(roleName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        */



        [Test]
        public void CreateAndDeleteRoles()
        {
            roleProvider = new RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", _applicationName);
            roleProvider.Initialize(null, config);

            // Add the role
            roleProvider.CreateRole("Administrator");
            string[] roles = roleProvider.GetAllRoles();
            Assert.AreEqual(1, roles.Length);
            Assert.AreEqual("Administrator", roles[0]);

            // now delete the role
            roleProvider.DeleteRole("Administrator", false);
            roles = roleProvider.GetAllRoles();
            Assert.AreEqual(0, roles.Length);
        }

        private void AddUser(string username, string password)
        {
            MembershipCreateStatus status;
            membershipProvider.CreateUser(username, password, username + "@bar.com", null,
                null, true, null, out status);
            if (status != MembershipCreateStatus.Success)
                Assert.Fail("User creation failed");
        }

        [Test]
        public void AddUsersToRoles()
        {
            roleProvider = new RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", _applicationName);
            roleProvider.Initialize(null, config);

            AddUser("eve", "eveeve!");
            AddUser("eve2", "eveeve!");
            AddUser("eve3", "eveeve!");
            roleProvider.CreateRole("Administrator");
            roleProvider.CreateRole("User");
            roleProvider.CreateRole("Editor");
            roleProvider.AddUsersToRoles(new string[] { "eve", "eve2" },
                new string[] { "Administrator", "User" });
            Assert.IsTrue(roleProvider.IsUserInRole("eve", "Administrator"));
            Assert.IsTrue(roleProvider.IsUserInRole("eve", "User"));
            Assert.IsFalse(roleProvider.IsUserInRole("eve", "Editor"));
            Assert.IsTrue(roleProvider.IsUserInRole("eve2", "Administrator"));
            Assert.IsTrue(roleProvider.IsUserInRole("eve2", "User"));
            Assert.IsFalse(roleProvider.IsUserInRole("eve2", "Editor"));

            roleProvider.AddUsersToRoles(new string[] { "eve3" },
                new string[] { "Editor", "User" });
            Assert.IsFalse(roleProvider.IsUserInRole("eve3", "Administrator"));
            Assert.IsTrue(roleProvider.IsUserInRole("eve3", "User"));
            Assert.IsTrue(roleProvider.IsUserInRole("eve3", "Editor"));
        }

        [Test]
        public void RemoveUsersFromRoles()
        {
            roleProvider = new RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", _applicationName);
            roleProvider.Initialize(null, config);

            AddUser("eve", "eveeve!");
            AddUser("eve2", "eveeve!");
            AddUser("eve3", "eveeve!");
            roleProvider.CreateRole("Administrator");
            roleProvider.CreateRole("User");
            roleProvider.CreateRole("Editor");


            // test with one user
            roleProvider.AddUsersToRoles(new string[] { "eve" },
                new string[] { "Editor", "User" });
            Assert.AreEqual(2, roleProvider.GetRolesForUser("eve").Length);
            Assert.IsTrue(roleProvider.IsUserInRole("eve", "Editor"));
            Assert.IsTrue(roleProvider.IsUserInRole("eve", "User"));

            // remove User role
            roleProvider.RemoveUsersFromRoles(new string[] { "eve" }, new string[] { "User" });
            Assert.IsFalse(roleProvider.IsUserInRole("eve", "User"));
            Assert.IsTrue(roleProvider.IsUserInRole("eve", "Editor"));
            Assert.AreEqual(1, roleProvider.GetRolesForUser("eve").Length);

            // try remove again
            roleProvider.RemoveUsersFromRoles(new string[] { "eve" }, new string[] { "User" });
            Assert.IsFalse(roleProvider.IsUserInRole("eve", "User"));



            // test with two users
            Assert.IsFalse(roleProvider.IsUserInRole("eve2", "Administrator"));
            roleProvider.AddUsersToRoles(new string[] { "eve2", "eve3" },
                new string[] { "Administrator", "User" });
            Assert.IsTrue(roleProvider.IsUserInRole("eve2", "Administrator"));
            Assert.IsTrue(roleProvider.IsUserInRole("eve3", "Administrator"));

            // remove admin role
            roleProvider.RemoveUsersFromRoles(new string[] { "eve2" }, new string[] { "Administrator" });
            Assert.IsFalse(roleProvider.IsUserInRole("eve2", "Administrator"));
            Assert.IsTrue(roleProvider.IsUserInRole("eve2", "User"));
            Assert.AreEqual(1, roleProvider.GetRolesForUser("eve2").Length);
            Assert.AreEqual("User", roleProvider.GetRolesForUser("eve2")[0]);


            // verify didn't touch other user
            Assert.IsTrue(roleProvider.IsUserInRole("eve3", "Administrator"));


            // try remove again
            roleProvider.RemoveUsersFromRoles(new string[] { "eve2" }, new string[] { "Administrator" });
            Assert.IsFalse(roleProvider.IsUserInRole("eve2", "Administrator"));


        }


        /// <summary>
        /// MySQL Bug #38243 Not Handling non existing user when calling AddUsersToRoles method 
        /// </summary>
        [Test]
        public void AddNonExistingUserToRole()
        {
            roleProvider = new RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", _applicationName);
            roleProvider.Initialize(null, config);

            roleProvider.CreateRole("Administrator");
            roleProvider.AddUsersToRoles(new string[] { "eve" },
                new string[] { "Administrator" });
            
            // adrian:
            // The original MySQL Connector Unit Tests use IsTrue but I don't think that makes 
            // sense.  If user is non-existant the role mapping should not occur.
            //Assert.IsTrue(roleProvider.IsUserInRole("eve", "Administrator"));
            Assert.IsFalse(roleProvider.IsUserInRole("eve", "Administrator"));
        }

        private void AttemptToAddUserToRole(string username, string role)
        {
            try
            {
                roleProvider.AddUsersToRoles(new string[] { username },
                    new string[] { role });
            }
            catch (ArgumentException)
            {
            }
        }

        [Test]
        public void IllegalRoleAndUserNames()
        {
            roleProvider = new RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", _applicationName);
            roleProvider.Initialize(null, config);

            AttemptToAddUserToRole("test", null);
            AttemptToAddUserToRole("test", "");
            roleProvider.CreateRole("Administrator");
            AttemptToAddUserToRole(null, "Administrator");
            AttemptToAddUserToRole("", "Administrator");
        }

        [Test]
        public void AddUserToRoleWithRoleClass()
        {
            Roles.CreateRole("Administrator");
            MembershipCreateStatus status;
            Membership.CreateUser("eve", "eve1@eve", "eve@boo.com", 
                "question", "answer", true, null, out status);
            Assert.AreEqual(MembershipCreateStatus.Success, status);

            Roles.AddUserToRole("eve", "Administrator");
            Assert.IsTrue(Roles.IsUserInRole("eve", "Administrator"));
        }

        [Test]
        public void GetRolesForUserTest()
        {
            roleProvider = new RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", _applicationName);
            roleProvider.Initialize(null, config);

            AddUser("eve", "eveeve!");
            roleProvider.CreateRole("Administrator");
            roleProvider.CreateRole("User");
            roleProvider.CreateRole("Editor");

            roleProvider.AddUsersToRoles(new string[] { "eve" },
                new string[] { "Editor", "User", "Administrator"});
            Assert.AreEqual(3, roleProvider.GetRolesForUser("eve").Length);
            Assert.IsTrue(roleProvider.IsUserInRole("eve", "Editor"));
            Assert.IsTrue(roleProvider.IsUserInRole("eve", "User"));
            Assert.IsTrue(roleProvider.IsUserInRole("eve", "Administrator"));
        }

        [Test]
        public void GetAllRolesTest()
        {
            roleProvider = new RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", _applicationName);
            roleProvider.Initialize(null, config);

            roleProvider.CreateRole("Administrator");
            roleProvider.CreateRole("User");
            roleProvider.CreateRole("Editor");


            var roles = roleProvider.GetAllRoles();
            Assert.AreEqual(3, roles.Length);
            Assert.IsTrue(roles.Contains("Administrator"));
            Assert.IsTrue(roles.Contains("User"));
            Assert.IsTrue(roles.Contains("Editor"));
        }

        [Test]
        public void CheckIsUserInRoleForNonExistantUser()
        {
            var actual = roleProvider.IsUserInRole("not-there", "admin");
            Assert.AreEqual(false, actual);
        }

        [Test]
        public void IsUserInRoleCrossDomain()
        {
            var provider = new MongoProviders.MembershipProvider();
            NameValueCollection config1 = new NameValueCollection();
            config1.Add("connectionStringName", "local");
            config1.Add("applicationName", _applicationName);
            config1.Add("passwordStrengthRegularExpression", "bar.*");
            config1.Add("passwordFormat", "Clear");
            provider.Initialize(null, config1);
            MembershipCreateStatus status;
            provider.CreateUser("foo", "bar!bar", "foo@bar.com", null, null, true, null, out status);

            var provider2 = new MongoProviders.MembershipProvider();
            NameValueCollection config2 = new NameValueCollection();
            config2.Add("connectionStringName", "local");
            config2.Add("applicationName", _appName2);
            config2.Add("passwordStrengthRegularExpression", ".*");
            config2.Add("passwordFormat", "Clear");
            provider2.Initialize(null, config2);

            roleProvider = new RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", _applicationName);
            roleProvider.Initialize(null, config);

            MongoProviders.RoleProvider r2 = new MongoProviders.RoleProvider();
            NameValueCollection configr2 = new NameValueCollection();
            configr2.Add("connectionStringName", "local");
            configr2.Add("applicationName", _appName2);
            r2.Initialize(null, configr2);

            roleProvider.CreateRole("Administrator");
            roleProvider.AddUsersToRoles(new string[] { "foo" },
                new string[] { "Administrator" });
            Assert.IsFalse(r2.IsUserInRole("foo", "Administrator"));

        }

    }
}
