import tkinter as tk
from tkinter import messagebox, font
import random


# Основной класс приложения для игры "Крестики-нолики 7x7"
class TicTacToeApp:
    def __init__(self, master):
        # Инициализация главного окна
        self.master = master
        self.master.title("Крестики-нолики 7x7")
        self.master.configure(bg='#f0f0f0')  # Установка цвета фона окна
        self.master.attributes('-fullscreen', True)  # Открытие окна во весь экран
        self.master.resizable(False, False)  # Запрет на изменение размера окна

        # Символы игроков и случайное определение, кто ходит первым
        self.player_symbols = ['X', 'O']
        random.shuffle(self.player_symbols)
        self.current_player = 0  # Установка первого игрока

        # Создание пустого поля 7x7 и матрицы для кнопок
        self.board = [['' for _ in range(7)] for _ in range(7)]
        self.buttons = [[None for _ in range(7)] for _ in range(7)]

        # Создание меню
        self.create_menu()

    def create_menu(self):
        # Очистка текущего окна
        self.clear_window()
        # Создание фрейма для размещения кнопок меню
        menu_frame = tk.Frame(self.master, bg='#f0f0f0', padx=20, pady=20)
        menu_frame.pack(expand=True)

        # Настройка шрифта для кнопок
        button_font = font.Font(family='Helvetica', size=24, weight='bold')
        buttons_options = {'font': button_font, 'bg': '#a7c7e7', 'fg': 'white', 'padx': 10, 'pady': 5}

        # Создание кнопок меню
        tk.Button(menu_frame, text="Играть с другом", **buttons_options,
                  command=lambda: self.setup_board('friend')).pack(fill=tk.BOTH, expand=True, pady=10)
        tk.Button(menu_frame, text="Играть с компьютером", **buttons_options,
                  command=lambda: self.setup_board('computer')).pack(fill=tk.BOTH, expand=True, pady=10)
        tk.Button(menu_frame, text="Правила", **buttons_options, command=self.show_rules).pack(fill=tk.BOTH,
                                                                                               expand=True, pady=10)
        tk.Button(menu_frame, text="Выход", **buttons_options, command=self.exit_app).pack(fill=tk.BOTH, expand=True,
                                                                                           pady=10)

    def setup_board(self, mode):
        # Очистка текущего окна
        self.clear_window()
        # Сброс игрового поля и установка текущего игрока
        self.board = [['' for _ in range(7)] for _ in range(7)]
        self.current_player = 0
        self.game_mode = mode

        # Создание метки для отображения статуса игры
        self.status_label = tk.Label(self.master, text='', font=('Arial', 20), bg='#f0f0f0', fg='black')
        self.status_label.grid(row=7, column=0, columnspan=7, sticky='ew')

        # Настройка кнопок игрового поля
        button_options = {'font': ('Arial', 20), 'width': 5, 'height': 2, 'bg': '#a7c7e7', 'fg': 'black'}
        for i in range(7):
            for j in range(7):
                btn = tk.Button(self.master, text='', **button_options, command=lambda x=i, y=j: self.make_move(x, y))
                btn.grid(row=i, column=j, sticky='nsew', padx=5, pady=5)
                self.buttons[i][j] = btn

        # Настройка сетки
        for i in range(7):
            self.master.grid_rowconfigure(i, weight=1)
            self.master.grid_columnconfigure(i, weight=1)
        self.master.grid_rowconfigure(7, weight=0)

        # Создание кнопки для возврата в меню
        tk.Button(self.master, text="Выйти в меню", font=('Arial', 12), bg='#a7c7e7', fg='black',
                  command=self.create_menu).grid(row=8, column=0, columnspan=7, sticky='nsew', pady=10)

        # Обновление статуса игры
        self.update_status()

    def make_move(self, x, y):
        if self.board[x][y] == '':
            # Обновление поля и кнопки после хода
            self.board[x][y] = self.player_symbols[self.current_player]
            self.buttons[x][y]['text'] = self.player_symbols[self.current_player]
            self.buttons[x][y]['disabledforeground'] = 'black'
            self.buttons[x][y]['state'] = 'disabled'

            # Проверка победы
            winning_line = self.check_win(x, y)
            if winning_line:
                for wx, wy in winning_line:
                    self.buttons[wx][wy]['bg'] = 'light green'
                if self.game_mode == 'computer' and self.current_player == 1:
                    messagebox.showinfo("Победа!", "Компьютер выиграл!")
                else:
                    messagebox.showinfo("Победа!", f"Игрок {self.player_symbols[self.current_player]} выиграл!")
                self.create_menu()
                return
            elif all(all(row) for row in self.board):
                # Проверка ничьи
                messagebox.showinfo("Ничья", "Игра закончилась вничью!")
                self.create_menu()
                return

            # Смена текущего игрока
            self.current_player = 1 - self.current_player
            self.update_status()

            # Ход компьютера, если режим игры "Играть с компьютером"
            if self.game_mode == 'computer' and self.current_player == 1:
                self.disable_buttons()
                self.master.after(500, self.computer_move)

    def check_win(self, x, y):
        # Проверка победы по всем направлениям
        directions = [(0, 1), (1, 0), (1, 1), (1, -1)]
        symbol = self.board[x][y]
        for dx, dy in directions:
            line = [(x, y)]
            for d in [1, -1]:
                nx, ny = x + dx * d, y + dy * d
                while 0 <= nx < 7 and 0 <= ny < 7 and self.board[nx][ny] == symbol:
                    line.append((nx, ny))
                    nx += dx * d
                    ny += dy * d
            if len(line) >= 4:
                return line
        return None

    def disable_buttons(self):
        # Отключение всех кнопок
        for row in self.buttons:
            for button in row:
                if button['state'] != 'disabled':
                    button['state'] = 'disabled'

    def enable_buttons(self):
        # Включение всех кнопок
        for row in self.buttons:
            for button in row:
                if button['text'] == '':
                    button['state'] = 'normal'

    def computer_move(self):
        # Ход компьютера, сначала проверка на возможность победы
        for check_win in [True, False]:
            for x in range(7):
                for y in range(7):
                    if self.board[x][y] == '':
                        self.board[x][y] = self.player_symbols[1] if check_win else self.player_symbols[0]
                        if self.check_win(x, y):
                            self.board[x][y] = ''
                            self.enable_buttons()
                            self.make_move(x, y)
                            return
                        self.board[x][y] = ''
        # Если выигрышный ход не найден, случайный ход
        empty_cells = [(x, y) for x in range(7) for y in range(7) if self.board[x][y] == '']
        if empty_cells:
            move = random.choice(empty_cells)
            self.enable_buttons()
            self.make_move(*move)

    def update_status(self):
        # Обновление статуса игры
        if self.game_mode == 'computer':
            if self.current_player == 0:
                status_text = f"Ваш ход: {self.player_symbols[self.current_player]}"
            else:
                status_text = "Ход компьютера"
        else:
            status_text = f"Ход игрока: {self.player_symbols[self.current_player]}"
        self.status_label['text'] = status_text

    def show_rules(self):
        # Показ правил игры
        messagebox.showinfo("Правила",
                            "Игроки по очереди ставят на свободные клетки поля 7x7 свои символы (X или O). Выигрывает тот, кто первым выстроит 4 своих символа в ряд по вертикали, горизонтали или диагонали.")

    def clear_window(self):
        # Очистка всех виджетов в окне
        for widget in self.master.winfo_children():
            widget.destroy()

    def exit_app(self):
        # Выход из приложения
        self.master.quit()


# Запуск приложения
if __name__ == "__main__":
    root = tk.Tk()
    app = TicTacToeApp(root)
    root.mainloop()
