/*
 * https://github.com/linuxunderground/be-rail
 *
 * Copyright (C) 2016-2017 Linuxunderground <be-rail@linuxunderground.be>
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version
 * 3.0 as published by the Free Software Foundation.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this software; if not, see
 * http://www.gnu.org/licenses/.
 */


#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QSqlQueryModel>
#include <QTableView>


class StationsTab : public QWidget
{
    Q_OBJECT

    public:
        explicit StationsTab(QWidget *parent = 0);

    private slots:
        void on_sectionClicked(int);

    private:
        QString stationsSelect;
        QSqlQueryModel *stationsModel;
        QTableView *stationsView;
};

class LinesTab : public QWidget
{
    Q_OBJECT

    public:
        explicit LinesTab(QWidget *parent = 0);

    private slots:
        void on_sectionClicked(int);

    private:
        QString linesSelect;
        QSqlQueryModel *linesModel;
        QTableView *linesView;
};

class MainWindow : public QMainWindow
{
    Q_OBJECT

    public:
        MainWindow();

    private slots:
        void quit();
        void about();

    private:
        void setupDB();
        void setupMenuBar();
};

#endif
