Assignment
================

* Course Title: __Distributed Systems Programming__
* Course Code: **DSP620S**
* Assessment: First Assignment
* Released on: 26/10/2020
* Due Date: 15/11/2020

# Problem

The purpose of this project is to design and implement **cali**, a __storage system__ for songs released by an artist or a group of artists. Each record stored in the system will be saved in a JSON file. A record can be represented as follows:
```json
{
	date: "22/10/2020",
	artists: [
		{
			name: "Winston Marshall",
			member: yes
		},
		{
			name: "Ben Lovett",
			member: yes
		},
		{
			name: "Baaba Maal",
			member: no
		}
	],
	band: "Mumford & Sons",
	songs: [
		{
			title: "There will be time",
			genre: "folk rock",
			platform: "Deezer"
		}
	]
}
```

The architecture of the system comprises a *client* and a *server* that communicate following a remote invocation paradigm. The following operations should be allowed in the system:

1. write a new record
2. update a record
3. read a record

To write a record, the client invokes a remote operation on the server and passes the record as an argument. Once the request is received, the server **hashes** the record using a __hash function__. The resulting hash code represents the key that will be attached to the record. To avoid duplication, the server checks whether such a record exists in the system. If not, it saves the record in the file and returns the key and a version number to the client. If on the contrary, the record already exists in the system, the server returns the key and the latest version attached to the key. A version is an additional identifier for a record. Its role is to support updates of records.

To update a record, the client sends the key attached to the record, a version and the modified copy of the record. When the version or the key passed by the client is unknown to the server, it returns an error with the message "Record does not exist!". When both the key and the version are known to the server, it saves the modified copy in the file with a new version attached to it. The newly created version becomes a node successor to the version passed by the client. Simply put, versioning should be handled like a **direct acyclic graph**. When the update operation is successful, the server returns the key and the newly generated version.

Finally, several options are considered for the client to read a record:
* If the client passes a key, it receives the record corresponding to the latest version depending on that key. When there is no such record, an error message "Record does not exist" is returned.
* If the client passes a key and a version, the record corresponding the combination of key and version is returned, if it exists. If not an error message is returned.
* If the client passes a criterion or a combination thereof, the server **streams** back all records satisfying the criteria. A criterion could be the name of an artist, the name of a band and the title of a song. When several criteria are combined, a disjunction of the constituting parts should be assumed. For example, if the client sends a criterion that includes the title of a song or the name of an artist, all records that contain either the name of the artist or the title of the song should be streamed back to the client in response. To improve the search time of a record, particularly when using criteria, you might consider implementing a *secondary index* that helps you locate records faster following the criteria.

Your task is to implement **cali** using gRPC as the remote invocation tool in the Ballerina programming language. More specifically, you will:
1. define the interface of the remote operations using __Protocol Buffer__;
2. generate the stubs on both the client and server;
3. implement both the client and the server.

Note that you can use the __crypto__ module to implement your hash function.


# Submission Instructions

* This assignment is to be completed by groups of *at most* four (04) students each.
* For each group, a repository should be created either on [Github](https://github.com) or [Gitlab](https://about.gitlab.com). The URL of the repostiory should be communicated by Saturday, October 31 2020 with all group members set up as contributors.
* The submission date is is Sunday, November 15 2020, midnight. Please note that *commits* after that deadline will not be accepted. Therefore, a submission will be assessed based on the clone of the repository at the deadline.
* Any group that fails to submit on time will be awarded the mark 0.
* Although this is a group project, each member will receive a mark that reflects his/her contribution in the project. More particularly, if a student's username does not appear in the commit log of the group repository, that student will be assumed to not have contributed to the project and thus be awarded the mark 0.
* Each group is expected to present its project after the submission deadline.
* There should be no assumption about the execution environment of your code. It could be run using a specific framework or on the command line.
* In the case of plagiarism (groups copying from each other or submissions copied from the Internet), all submissions involved will be awarded the mark 0, and each student will receive a warning.