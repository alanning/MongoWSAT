using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MongoDB.Driver;
using MongoDB.Bson;
using MongoDB.Bson.Serialization;
using MongoDB.Bson.Serialization.IdGenerators;
using FluentMongo.Linq;

namespace MongoWSAT.Tests
{
    [TestClass]
    public class DecimalConversion
    {
        public class Employee
        {
            public Guid Id { get; set; }
            public string Name { get; set; }
            public decimal Salary { get; set; }
        }

        [TestMethod]
        public void decimals_are_serialized_correctly()
        {
            BsonClassMap.RegisterClassMap<Employee>();

            var connStr = "mongodb://localhost/";
            var server = MongoServer.Create(connStr);
            var test = server.GetDatabase("test");
            var people = test.GetCollection<Employee>("employees");
            people.RemoveAll();

            var emp = new Employee { Name = "Adrian", Salary = 50000.1m };
            people.Save(emp);

            var emps = people.Find(new QueryDocument("Name", "Adrian")).ToArray();
            var peeps = people.AsQueryable().Where(p => p.Name == "Adrian").ToArray();

            Assert.AreEqual(1, emps.Length);
            Assert.AreEqual(emps[0].Salary, 50000.1m);


            Assert.AreEqual(1, peeps.Length);
            Assert.AreEqual(peeps[0].Salary, 50000.1m);

        }
    }
}
