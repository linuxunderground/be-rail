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


#include "mainwindow.h"

//#include <QtWidgets>
//#include <QAction>
#include <QLayout>
#include <QApplication>
#include <QSqlDatabase>
#include <QSqlTableModel>
#include <QTableView>
#include <QMessageBox>
#include <QMenu>
#include <QMenuBar>
#include <limits>

MainWindow::MainWindow()
{
    setupMenuBar();
    resize(640, 480);
    showTelCode();
}

void MainWindow::about()
{
    QMessageBox::about(this, tr("About Menu"),
            tr("<b>be-rail</b> "
               "version "STR_VERSION"<br>"));
               //"DATA: "DATADIR));
}

void MainWindow::setupMenuBar()
{
    QMenu *helpMenu = menuBar()->addMenu(tr("&Help"));

    helpMenu->addAction(tr("About"), this, &MainWindow::about);
    //QAction *AboutAction = helpMenu->addAction(tr("About")); 
    //connect(AboutAction, SIGNAL(triggered()), this, SLOT(about()));

    helpMenu->addAction(tr("About Qt"), qApp, &QApplication::aboutQt);
    //QAction *AboutQtAction = helpMenu->addAction(tr("About Qt"));
    //connect(AboutQtAction, SIGNAL(triggered()), qApp, SLOT(aboutQt()));
}

void MainWindow::showTelCode()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName("localhost");
    db.setDatabaseName(DATADIR "/be-rail.sqlite");
    //db.setDatabaseName("be-rail.sqlite");
    db.setUserName("root");
    db.setPassword("");

    if (!db.open())
    {
        QMessageBox::critical(this, tr("Error"), tr("sqlite database not found: " DATADIR "/be-rail.sqlite"));
    }

     QSqlTableModel *stationModel = new QSqlTableModel;
     stationModel->setTable("stations");
     stationModel->select();
     stationModel->removeColumn(0);
     stationModel->setHeaderData(0, Qt::Horizontal,tr("Line"));
     stationModel->setHeaderData(1, Qt::Horizontal,tr("OOS"));
     stationModel->setHeaderData(2, Qt::Horizontal,tr("Station"));
     stationModel->setHeaderData(3, Qt::Horizontal,tr("Code"));
     stationModel->setHeaderData(4, Qt::Horizontal,tr("Old code"));
     stationModel->setHeaderData(5, Qt::Horizontal,tr("Remark"));
 
     QTableView *stationView = new QTableView;
     stationView->setModel(stationModel);
     stationView->resizeColumnsToContents();
     /*
     stationView->setVisible(false);
     QRect vpsav = stationView->viewport()->geometry();
     QRect vpnew = vpsav;
     vpnew.setWidth(std::numeric_limits<int>::max());
     stationView->viewport()->setGeometry(vpnew);

     stationView->resizeRowsToContents();
     stationView->viewport()->setGeometry(vpsav);
     stationView->setVisible(true);
*/
     QVBoxLayout *MainLayout = new QVBoxLayout;
     MainLayout->addWidget(stationView);
 
     QWidget *centerZone = new QWidget;
     centerZone->setLayout(MainLayout);
     setCentralWidget(centerZone);
}
