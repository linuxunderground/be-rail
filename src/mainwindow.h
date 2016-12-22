/*
 * https://github.com/linuxunderground/be-rail
 *
 * Copyright (C) 2016 Linuxunderground <be-rail@linuxunderground.be>
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

//#include <QtWidgets>
#include <QMainWindow>

class MainWindow : public QMainWindow
{
    Q_OBJECT

    public:
        MainWindow();

    private slots:
        void about();

    private:
        void setupMenuBar();
        void showTelCode();

        //QAction *aboutAct;
//        QMenu *mainWindowMenu;
};

#endif
