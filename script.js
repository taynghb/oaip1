const users = [
{ id: 1, name: "Anna", age: 22, city: "Moscow", isActive: true },
{ id: 2, name: "Oleg", age: 17, city: "Kazan", isActive: false },
{ id: 3, name: "Ivan", age: 30, city: "Moscow", isActive: true },
{ id: 4, name: "Maria", age: 25, city: "Sochi", isActive: false }
];

function getActiveUsers(users){
    return users.filter(user => user.isActive)
}
const getUserNames = (users) => map(users => users.name) 


function  findUserById(users, id){
    return users.find(user => user.id === id) || null;
}

function getUsersStatistics(users){ 
    return users.reduce((acc, user) =>{
        acc.total++
        if(user.isActive) acc.active++
        else acc.inactive++
        return acc
    }, {total: total, active: active, inactive:inactive})
    
}   

function getAverageAge(users){
    return users.reduce((total, user) => total + user.age, 0) / users.length;
}

function groupUsersByCity(users){
    return users.reduce((acc, user) => {
        const city = user.city
        if (!acc[city]) {
            acc[city] = [];
        }
        acc[city].push(user);
        return acc;
    }, {});

}