// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/jballerina.java;
import ballerina/persist;
import ballerinax/persist.inmemory;

const EMAIL_REPORT = "emailreports";
final isolated table<EmailReport> key(id) emailreportsTable = table [];

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final map<inmemory:InMemoryClient> persistClients;

    public isolated function init() returns persist:Error? {
        final map<inmemory:TableMetadata> metadata = {
            [EMAIL_REPORT]: {
                keyFields: ["id"],
                query: queryEmailreports,
                queryOne: queryOneEmailreports
            }
        };
        self.persistClients = {[EMAIL_REPORT]: check new (metadata.get(EMAIL_REPORT).cloneReadOnly())};
    }

    isolated resource function get emailreports(EmailReportTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get emailreports/[string id](EmailReportTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post emailreports(EmailReportInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach EmailReportInsert value in data {
            lock {
                if emailreportsTable.hasKey(value.id) {
                    return persist:getAlreadyExistsError("EmailReport", value.id);
                }
                emailreportsTable.put(value.clone());
            }
            keys.push(value.id);
        }
        return keys;
    }

    isolated resource function put emailreports/[string id](EmailReportUpdate value) returns EmailReport|persist:Error {
        lock {
            if !emailreportsTable.hasKey(id) {
                return persist:getNotFoundError("EmailReport", id);
            }
            EmailReport emailreport = emailreportsTable.get(id);
            foreach var [k, v] in value.clone().entries() {
                emailreport[k] = v;
            }
            emailreportsTable.put(emailreport);
            return emailreport.clone();
        }
    }

    isolated resource function delete emailreports/[string id]() returns EmailReport|persist:Error {
        lock {
            if !emailreportsTable.hasKey(id) {
                return persist:getNotFoundError("EmailReport", id);
            }
            return emailreportsTable.remove(id).clone();
        }
    }

    public isolated function close() returns persist:Error? {
        return ();
    }
}

isolated function queryEmailreports(string[] fields) returns stream<record {}, persist:Error?> {
    table<EmailReport> key(id) emailreportsClonedTable;
    lock {
        emailreportsClonedTable = emailreportsTable.clone();
    }
    return from record {} 'object in emailreportsClonedTable
        select persist:filterRecord({
                                        ...'object
                                    }, fields);
}

isolated function queryOneEmailreports(anydata key) returns record {}|persist:NotFoundError {
    table<EmailReport> key(id) emailreportsClonedTable;
    lock {
        emailreportsClonedTable = emailreportsTable.clone();
    }
    from record {} 'object in emailreportsClonedTable
    where persist:getKey('object, ["id"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("EmailReport", key);
}

