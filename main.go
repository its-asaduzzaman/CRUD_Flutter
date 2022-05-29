package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

type Tasks struct {
	ID         string `json:"id"`
	TaskName   string `json:"task_name"`
	TaskDetail string `json:"task_detail"`
	Data       string `json:"date"`
}

var tasks []Tasks

func allTasks() {
	task := Tasks{
		ID:         "1",
		TaskName:   "New Project",
		TaskDetail: "You must lead the project and finish it",
		Data:       "2022-01-22",
	}
	task1 := Tasks{
		ID:         "2",
		TaskName:   "Power Project",
		TaskDetail: "It will take some days to finish",
		Data:       "2022-01-23",
	}
	tasks = append(tasks, task, task1)
	fmt.Println("your task are", tasks)
}

func homePage(w http.ResponseWriter, r *http.Request) {
	fmt.Println("i am home")
}
func getTasks(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/")
	json.NewEncoder(w).Encode(tasks)
}
func getTask(w http.ResponseWriter, r *http.Request) {
	taskId := mux.Vars(r)
	flag := false
	for i := 0; i < len(tasks); i++ {
		if taskId["id"] == tasks[i].ID {
			json.NewEncoder(w).Encode(tasks[i])
			flag = true
			break
		}

	}
	if flag == false {
		json.NewEncoder(w).Encode(map[string]string{"status": "Error"})
	}
}
func crateTask(w http.ResponseWriter, r *http.Request) {
	fmt.Println("i am home")
}
func deleteTask(w http.ResponseWriter, r *http.Request) {
	fmt.Println("i am home")
}
func updateTask(w http.ResponseWriter, r *http.Request) {
	fmt.Println("i am home")
}

func HandleRoutes() {
	router := mux.NewRouter()
	router.HandleFunc("/", homePage).Methods("GET")
	router.HandleFunc("/gettasks", getTasks).Methods("GET")
	router.HandleFunc("/gettask/{id}", getTask).Methods("GET")
	router.HandleFunc("/create", crateTask).Methods("POST")
	router.HandleFunc("/delete/{id}", deleteTask).Methods("DELETE")
	router.HandleFunc("/update/{id}", updateTask).Methods("PUT")
	log.Fatal(http.ListenAndServe(":8082", router))
}

func main() {

	fmt.Println("Hello samrat")
	allTasks()
	HandleRoutes()
}
