using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using MongoDB.Driver;

namespace MongoProviders.UnitTests
{
    public class BaseTest
    {

        protected MongoServer _server;
        protected MongoDatabase _db;
        protected string _defaultMembershipCollectionName;
        protected string _defaultRoleCollectionName;

        public virtual void Setup()
        {
            var connStr = "mongodb://127.0.0.1/";
            _server = MongoServer.Create(connStr);
            _db = _server.GetDatabase(MongoProviders.MembershipProvider.DEFAULT_DATABASE_NAME);
            _defaultMembershipCollectionName = MongoProviders.MembershipProvider.DEFAULT_USER_COLLECTION_NAME;
            _defaultRoleCollectionName = MongoProviders.RoleProvider.DEFAULT_ROLE_COLLECTION_NAME;
        }
    }
}
