const expenseTracker = {
    expenses: [],
    addExpense(title, summ, category){
        if (!title || summ <= 0 || !category){
            console.log("введите корректные данные");
            return
        }
        const id = 0;
        this.expenses.push({
            id: id++,
            title: title,
            amount: summ,
            category: category
        });
    },
    printAllExpenses() {
        if (expenses.length == 0){
            return "список пуст"
        }
        return this.expenses.forEach(exp => {
      console.log(`ID: exp.id ${exp.title} | ${exp.amount} руб. | Категория: ${exp.category}`);
    });
    },
    getTotalAmount() { 
        const total = this.expenses.reduce((summary,exp) => summary += exp.amount, 0)
        return `Итого операций совершено на сумму ${total}`
    },
    getExpensesByCategory(category) {
        let filtered = this.expenses.filter(exp => expenses.category == category)
        console.log("всего потрачено: ")
        return filtered.reduce((sum,exp) => sum += exp.amount, 0)
    },
    findExpenseByTitle(find) {
    const expense = this.expenses.find(exp => exp.title.toLowerCase().includes(query.toLowerCase()));
    
    if (expense) 
      return expense;
    else {
      console.log(`Расход с названием "${query}" не найден.`);
    }
    },
    deleteExpense(id) {
    const initialLength = this.expenses.length;
    this.expenses = this.expenses.filter(exp => exp.id !== id);
    
    if (this.expenses.length < initialLength) {
      console.log("Расход с ID {id} удален.");
    } else {
      console.log("Ошибка: ID не найден.");
    }
  },

  printStats() {
    console.log("Статистика по категориям");
    const stats = {};
    
    this.expenses.forEach(exp => {
      stats[exp.category] = (stats[exp.category] || 0) + exp.amount;
    });

    for (let category in stats) {
      console.log(`${category}: ${stats[category]} руб.`);
    }
  }

}
