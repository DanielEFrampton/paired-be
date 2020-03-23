## GraphQL
Our GraphQL endpoints fall into three categories: queries, mutations, and filter queries.

### Queries

1. [**getUser(id: ID)**](#get-user) *Finds a specific user in the database*
  * Example Query
  ```
  {
      getUser(id: "1") {
        name
        program
        module
        id
        image
      }
    }
  ```
  * Example Response
  ```json
  { "data": {
    "getUser": {
      "name": "Bowen Arrow",
      "program": "BE",
      "module": "4",
      "id": "208",
      "image": "https://loremflickr.com/300/300"
    }
  }
}
  ```
2. [**getUserByFirebaseID(id: ID)**](#get-user-by-firebase-id)  *Finds user by FirebaseID for logging in*
  * Example Query
  ```
      { getUserByFirebaseID(
      id: "er561v3h0si34bu56m1l2e34v7ax"
        ) {
           name
           program
           module
           id
           image
           pronouns
           email
           phoneNumber
           slack
           skills
        }
      }
   ```
  * Example Response
  ```json
    { "data":
      { "getUserByFirebaseID":
        {
          "name": "Alec Tricity",
          "program": "BE",
          "module": "4",
          "id": "213",
          "image": "https://loremflickr.com/300/300",
          "pronouns": "She/her",
          "email": "patrina@konopelski.info",
          "phoneNumber": "5555550100",
          "slack": "Zeke N. Yeshallfind",
          "skills": [
            "Ruby",
            "Rails"
          ]
        }
      }
    }
  ```
3. [**getUserPairings(id: ID)**](#get-user-pairings)  *Will return a list of booked pairings where the user is the pairer or pairee*
  * Example Query
  ```
    { getUserPairings(id: "1")
      {
        pairer {
          name
          module
          program
          id
          pronouns
          slack
          image
        }
        pairee {
          name
          module
          program
          pronouns
          slack
          image
        }
        date
        time
        id
        notes
      }
    }
  ```
  * Example Response
  ```json
  { "data":
    { "getUserPairings":
      [
        { "pairer":
            {
              "name": "Bowen Arrow",
              "module": "4",
              "program": "BE",
              "id": "208",
              "pronouns": "She/her",
              "slack": "Kenney C. Strait",
              "image": "https://loremflickr.com/300/300"
            },
          "pairee":
            {
              "name": "Harmon Ikka",
              "module": "2",
              "program": "BE",
              "pronouns": "She/her",
              "slack": "Ty Knotts",
              "image": "https://loremflickr.com/300/300"
            },
          "date": "Wed Apr 03 2020",
          "time": "lunch",
          "id": "4077",
          "notes": "Help me with Battleship!"
        },
        { "pairer":
          {
            "name": "Bowen Arrow",
            "module": "4",
            "program": "BE",
            "id": "208",
            "pronouns": "She/her",
            "slack": "Kenney C. Strait",
            "image": "https://loremflickr.com/300/300"
          },
          "pairee":
            {
              "name": "Curt N. Rodd",
              "module": "5",
              "program": "BE",
              "pronouns": "She/her",
              "slack": "Noah Riddle",
              "image": "https://loremflickr.com/300/300"
            },
          "date": "Wed Apr 03 2020",
          "time": "lunch",
          "id": "4073",
          "notes": "Need to work on MVC"
        },
      ]
    }
  }
  ```
4. [**getUsers**](#get-user)  *Returns all users in the database*
  * Example Query
  ```
  {
    getUsers {
      name
      program
      module
    }
  }
  ```
  * Example Response
  ```json
  { "data": {
    "getUsers": [
      {
        "name": "Ben Down",
        "program": "BE",
        "module": "3"
      },
      {
        "name": "Neil B. Formy",
        "program": "BE",
        "module": "2"
      },
      {
        "name": "Bowen Arrow",
        "program": "BE",
        "module": "4"
      },
      {
        "name": "Eli Ondefloor",
        "program": "BE",
        "module": "3"
      },
      {
        "name": "Curt N. Rodd",
        "program": "BE",
        "module": "5"
      },
      {
        "name": "R. M. Pitt",
        "program": "BE",
        "module": "1"
      },
    ]
  }
}
```

5. [**getPairings**](#get-pairings)  *Returns all pairings*
  * Example Query
  ```
  { getPairings
    {
      id
      pairer {
       name
      }
      pairee {
       name
      }
      date
      time
    }
  }
  ```
  * Example Response
  ```json
  { "data": {
    "getPairings": [
      {
        "id": "4082",
        "pairer": {
          "name": "Eli Ondefloor"
        },
        "pairee": null,
        "date": "Wed Apr 03 2020",
        "time": "lunch"
      },
      {
        "id": "4073",
        "pairer": {
          "name": "Bowen Arrow"
        },
        "pairee": {
          "name": "Curt N. Rodd"
        },
        "date": "Wed Apr 03 2020",
        "time": "lunch"
      },
      {
        "id": "4074",
        "pairer": {
          "name": "Curt N. Rodd"
        },
        "pairee": {
          "name": "Bowen Arrow"
        },
        "date": "Wed Apr 03 2020",
        "time": "lunch"
      },
      {
        "id": "4075",
        "pairer": {
          "name": "Curt N. Rodd"
        },
        "pairee": {
          "name": "R. M. Pitt"
        },
        "date": "Wed Apr 03 2020",
        "time": "lunch"
      },
      {
        "id": "4076",
        "pairer": {
          "name": "R. M. Pitt"
        },
        "pairee": {
          "name": "Curt N. Rodd"
        },
        "date": "Wed Apr 03 2020",
        "time": "lunch"
      },
    ]
  }
}
  ```

6. [**getPairing (id: ID)**](#get-pairing)  *Finds a specific pairing by pairing id*
  * Example Query
  ```
  { getPairing(id: "1") {
      pairer {
        name
        module
        program
        id
        pronouns
        skills
        slack
        image
      }
      pairee {
        name
      }
      date
      time
      id
    }
  }
  ```
  * Example Response
  ```json
  {
    "data": {
      "getPairing": {
        "pairer": {
          "name": "Hill",
          "module": "3",
          "program": "BE",
          "id": "216",
          "pronouns": "she/her",
          "skills": [
            "paired",
            "ruby",
            "react"
          ],
          "slack": "@h34",
          "image": "https://avatars3.githubusercontent.com/u/36748280?v=4"
        },
        "pairee": {
          "name": "Kylie "
        },
        "date": "Mon May 13 2019",
        "time": "morning",
        "id": "4463"
      }
    }
  }
  ```

8. [**getUserStats (id: ID)**](#get-user-stats)  *Returns a specific users statistics on pairing hours*
  * Example Query
  ```
  {
    getUserStats(id: "1") {
      name
      totalBookings
      totalMentorHours
      totalHoursMentored
      mentees {
        name }
      }
  }
  ```
  * Example Response
  ```json
  { "data":
    { "getUserStats":
      {
        "name": "Bowen Arrow",
        "totalBookings": 2,
        "totalMentorHours": 1,
        "totalHoursMentored": 0.5,
        "mentees": [
          {
            "name": "Harmon Ikka"
          },
          {
            "name": "Curt N. Rodd"
          }
        ]
      }
    }
  }
  ```

### Mutations

1. [**createUser(CreateUserInput)**](#create-user)  *Used during profile creation. Will create a new user in the database*
  * Example Query
  ```
  mutation {
          user: createUser(
          input: {
            name: "Samantha"
            email: "so@gmail.com"
            image: "https://robohash.org/image"
            firebaseID: "425tgw2g4w43"
            module: "3"
            program: "BE"
            phoneNumber: "4231563232"
            pronouns: "she/her"
            slack: "rer7891"
            skills: ["ruby", "rails", "graphql"]
          }
          ) {
            name
            program
            module
            id
            image
            pronouns
            email
            slack
            skills
            }
          }
  ```
  * Example Response
  ```json
  { "data": {
    "user": {
      "name": "Samantha",
      "program": "BE",
      "module": "3",
      "id": "411",
      "image": "https://robohash.org/image",
      "pronouns": "she/her",
      "email": "so@gmail.com",
      "slack": "rer7891",
      "skills": [
        "ruby",
        "rails",
        "graphql"
      ]
    }
  }
}
  ```

2. [**updateUser(UpdateUserInput)**](#update-user)  *Allows a user to update their profile details.*
  * Example Query
  ```
  mutation {
    user: updateUser(
      input: {
        id: "11"
        name: "Carl Crockett"
        email: "cap@gmail.com"
        module: 2
        program: "BE"
        pronouns: "she/her"
        slack: "capleugh"
        skills: ["rspec", "react", "ruby"]
      }
    ) {
      name
      program
      module
      id
      image
      pronouns
      email
      slack
      skills
    }
  }
  ```
  * Example Response
  ```json
  {
    "data": {
      "user": {
        "name": "Carl Crockett",
        "program": "BE",
        "module": "2",
        "id": "412",
        "image": "https://robohash.org/image",
        "pronouns": "she/her",
        "email": "cap@gmail.com",
        "slack": "capleugh",
        "skills": [
        "rspec",
        "react",
        "ruby"
        ]
      }
    }
  }
  ```

3. [**deleteUser(DeleteUserInput)**](#delete-user)  *Allows a user to delete their account.*
  * Example Query
  ```
  mutation {
    deleteUser(
      input:{
        id: "121" } )
    {
    name
    }
  }
  ```
  * Example Response
  ```json
  {
    "data": {
      "deleteUser": {
        "name": "Carl Crockett"
      }
    }
  }
  ```
4. [**createPairings(createPairingsInput)**](#create-pairings)  *Creates open pairings for a user when they set availability. Pairee is nil.*
  * Example Query
  ```
    mutation {
      createPairings(input: {
        pairings: [
          {
            date:"Mon Apr 29 2019",
            time:"morning",
            pairer:"5caa7eebfdebb8348e53a48e"
          },
          {
            date:"Mon May 06 2019",
            time:"morning",
            pairer:"5caa7eebfdebb8348e53a48e"
          }
        ]
      }) {
        unbookedPairings
        {
          pairer {id}
          date
          time
        }
      }
    }
  ```
  * Example Response
  ```json
  {
  "data": {
    "createPairings": {
      "unbookedPairings": [
        {
          "pairer": {
            "id": "411"
          },
          "date": "Mon Apr 29 2019",
          "time": "morning"
        },
        {
          "pairer": {
            "id": "411"
          },
          "date": "Mon May 06 2019",
          "time": "morning"
        }
      ]
    }
  }
}
  ```
5. [**updatePairings(updatePairingsInput)**](#update-pairings)  *When a pairing is booked this updates the pairee from nil to an assigned pairee.*
  * Example Query
  ```
  mutation {
    updatePairing(input: {
          id: "1"
          pairee: "23"
          notes: "I need help with Flashcards"
          }) {
    pairer {
      name
      module
      program
      id
      pronouns
        slack
        image
    }
    pairee {
      name
      module
      program
      id
      pronouns
      slack
      image
    }
      date
      time
      id
      notes
    }
  }
  ```
  * Example Response
  ```json
  {
    "data": {
      "updatePairing": {
        "pairer": {
          "name": "Ann",
          "module": "2",
          "program": "FE",
          "id": "267",
          "pronouns": "she/her",
          "slack": "Ann",
          "image": "https://avatars0.githubusercontent.com/u/34483051?v=4"
        },
        "pairee": {
          "name": "Carl Crockett",
          "module": "2",
          "program": "BE",
          "id": "411",
          "pronouns": "she/her",
          "slack": "capleugh",
          "image": "https://robohash.org/image"
        },
        "date": "Mon Jul 29 2019",
        "time": "lunch",
        "id": "4702",
        "notes": "I need help with Flashcards"
      }
    }
  }
  ```

6. [**deletePairing(id: ID)**](#delete-pairing)  *Deletes a specific date and time of availability for a user.*
  * Example Query
  ```
   mutation {
             pairing: deletePairing(
               input: {
                 id: #{id: "11"}
               }
             ){
               pairer {id}
               pairee {id}
             }
           }
  ```
  * Example Response
  ```json
  {
    "data": {
      "pairing": {
        "pairer": {
          "id": "219"
        },
        "pairee": null
      }
    }
  }
  ```
7. [**deletePairings(id: ID)**](#delete-pairings)  *Deletes all old availability for a user when they update their availability.*
  * Example Query
  ```
   mutation {
        deletePairings(
          input:{
            id: "122"
          }
        ) {
          pairer { id }
        }
      }
  ```
  * Example Response
  ```json
  {
    "data": {
      "deletePairings": {
        "pairer": null
      }
    }
  }
  ```

### Filter Queries

1. [**getPairing (id: ID)**](#get-pairing)  *Returns all available pairings filtered by program, mod and date*
  * Example Query
  ```
  {
    getAvailablePairings(filter: {
      program: "FE",
      module: 2,
      date: "Wed Apr 04 2020"
    }) {
       pairer {
         name
         module
         program
         id
         pronouns
         skills
         slack
         image
       }
       date
       time
       id
     }
  }
  ```
  * Example Response
  ```json
  { "data":
    { "getAvailablePairings":
      [
        { "pairer":
          {
            "name": "Eli Ondefloor",
            "module": "3",
            "program": "BE",
            "id": "209",
            "pronouns": "She/her",
            "skills": [
              "Armand Hammer",
              "Luna Tick",
              "Brock Lee",
              "Rusty Fossat",
              "Lou Pole",
              "Jane Linkfence"
            ],
            "slack": "Candice B. Fureal",
            "image": "https://loremflickr.com/300/300"
          },
          "date": "Wed Apr 03 2020",
          "time": "lunch",
          "id": "4082"
        }
      ]
    }
  }
  ```
