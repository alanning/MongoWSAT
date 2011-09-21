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

            _db.DropCollection(MongoProviders.RoleProvider.DEFAULT_ROLE_COLLECTION_NAME);

			membershipProvider = new MongoProviders.MembershipProvider();
			NameValueCollection config = new NameValueCollection();
			config.Add("connectionStringName", "local");
			config.Add("applicationName", "/");
			membershipProvider.Initialize(null, config);
		}


        /*
        [TestMethod()]
        public void RoleProviderConstructorTest()
        {
            RoleProvider target = new RoleProvider();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }

        [TestMethod()]
        public void AddUsersToRolesTest()
        {
            RoleProvider target = new RoleProvider(); // TODO: Initialize to an appropriate value
            string[] usernames = null; // TODO: Initialize to an appropriate value
            string[] roleNames = null; // TODO: Initialize to an appropriate value
            target.AddUsersToRoles(usernames, roleNames);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        [TestMethod()]
        public void CreateRoleTest()
        {
            RoleProvider target = new RoleProvider(); // TODO: Initialize to an appropriate value
            string roleName = string.Empty; // TODO: Initialize to an appropriate value
            target.CreateRole(roleName);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        [TestMethod()]
        public void DeleteRoleTest()
        {
            RoleProvider target = new RoleProvider(); // TODO: Initialize to an appropriate value
            string roleName = string.Empty; // TODO: Initialize to an appropriate value
            bool throwOnPopulatedRole = false; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = target.DeleteRole(roleName, throwOnPopulatedRole);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

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
        public void GetAllRolesTest()
        {
            RoleProvider target = new RoleProvider(); // TODO: Initialize to an appropriate value
            string[] expected = null; // TODO: Initialize to an appropriate value
            string[] actual;
            actual = target.GetAllRoles();
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        [TestMethod()]
        public void GetRolesForUserTest()
        {
            RoleProvider target = new RoleProvider(); // TODO: Initialize to an appropriate value
            string username = string.Empty; // TODO: Initialize to an appropriate value
            string[] expected = null; // TODO: Initialize to an appropriate value
            string[] actual;
            actual = target.GetRolesForUser(username);
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
        public void IsUserInRoleTest()
        {
            RoleProvider target = new RoleProvider(); // TODO: Initialize to an appropriate value
            string username = string.Empty; // TODO: Initialize to an appropriate value
            string roleName = string.Empty; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = target.IsUserInRole(username, roleName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        [TestMethod()]
        public void RemoveUsersFromRolesTest()
        {
            RoleProvider target = new RoleProvider(); // TODO: Initialize to an appropriate value
            string[] usernames = null; // TODO: Initialize to an appropriate value
            string[] roleNames = null; // TODO: Initialize to an appropriate value
            target.RemoveUsersFromRoles(usernames, roleNames);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
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
            roleProvider = new MongoProviders.RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", "/");
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
            membershipProvider.CreateUser(username, password, "foo@bar.com", null,
                null, true, null, out status);
            if (status != MembershipCreateStatus.Success)
                Assert.Fail("User creation failed");
        }

        [Test]
        public void AddUserToRole()
        {
            roleProvider = new MongoProviders.RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", "/");
            roleProvider.Initialize(null, config);

            AddUser("eve", "eveeve!");
            roleProvider.CreateRole("Administrator");
            roleProvider.AddUsersToRoles(new string[] { "eve" },
                new string[] { "Administrator" });
            Assert.IsTrue(roleProvider.IsUserInRole("eve", "Administrator"));

            roleProvider.RemoveUsersFromRoles(new string[] { "eve" }, new string[] { "Administrator" });
            Assert.IsFalse(roleProvider.IsUserInRole("eve", "Administrator"));
        }

        /// <summary>
        /// MySQL Bug #38243 Not Handling non existing user when calling AddUsersToRoles method 
        /// </summary>
        [Test]
        public void AddNonExistingUserToRole()
        {
            roleProvider = new MongoProviders.RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", "/");
            roleProvider.Initialize(null, config);

            roleProvider.CreateRole("Administrator");
            roleProvider.AddUsersToRoles(new string[] { "eve" },
                new string[] { "Administrator" });
            Assert.IsTrue(roleProvider.IsUserInRole("eve", "Administrator"));
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
            roleProvider = new MongoProviders.RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", "/");
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
        public void IsUserInRoleCrossDomain()
        {
            var provider = new MongoProviders.MembershipProvider();
            NameValueCollection config1 = new NameValueCollection();
            config1.Add("connectionStringName", "local");
            config1.Add("applicationName", "/");
            config1.Add("passwordStrengthRegularExpression", "bar.*");
            config1.Add("passwordFormat", "Clear");
            provider.Initialize(null, config1);
            MembershipCreateStatus status;
            provider.CreateUser("foo", "bar!bar", "foo@bar.com", null, null, true, null, out status);

            var provider2 = new MongoProviders.MembershipProvider();
            NameValueCollection config2 = new NameValueCollection();
            config2.Add("connectionStringName", "local");
            config2.Add("applicationName", "/myapp");
            config2.Add("passwordStrengthRegularExpression", ".*");
            config2.Add("passwordFormat", "Clear");
            provider2.Initialize(null, config2);

            roleProvider = new MongoProviders.RoleProvider();
            NameValueCollection config = new NameValueCollection();
            config.Add("connectionStringName", "local");
            config.Add("applicationName", "/");
            roleProvider.Initialize(null, config);

            MongoProviders.RoleProvider r2 = new MongoProviders.RoleProvider();
            NameValueCollection configr2 = new NameValueCollection();
            configr2.Add("connectionStringName", "local");
            configr2.Add("applicationName", "/myapp");
            r2.Initialize(null, configr2);

            roleProvider.CreateRole("Administrator");
            roleProvider.AddUsersToRoles(new string[] { "foo" },
                new string[] { "Administrator" });
            Assert.IsFalse(r2.IsUserInRole("foo", "Administrator"));
        }

    }
}
