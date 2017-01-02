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


#include "mainwindow.h"

#include <limits>
#include <QApplication>
#include <QDesktopWidget>
#include <QLayout>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlTableModel>
#include <QHeaderView>
#include <QStyleOptionHeader>
#include <QMessageBox>
#include <QMenu>
#include <QMenuBar>
#include <QDebug>

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
               "version " STR_VERSION "<br>"));
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

void MainWindow::on_sectionClicked(int aIndex)
{
    if (stationView->horizontalHeader()->sortIndicatorOrder()==Qt::AscendingOrder)
    {
        stationView->sortByColumn(aIndex,Qt::AscendingOrder);
    }
    else
    {
        stationView->sortByColumn(aIndex,Qt::DescendingOrder);
    }
}

void MainWindow::showTelCode()
{
    QHeaderView *hHeaderView;

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    //db.setDatabaseName(DATADIR "/be-rail.sqlite");
    db.setDatabaseName("be-rail.sqlite");

    if (!db.open())
    {
        QMessageBox::critical(this, tr("Error"), tr("Connection with database " DATADIR "/be-rail.sqlite failed"));
        qDebug() << "Error: connection with database " DATADIR "/be-rail.sqlite failed";
    }
    else
    {
        qDebug() << "Database: connection with " DATADIR "/be-rail.sqlite";
    }

#ifdef QT_DEBUG
    qDebug() << "Available drivers :";
    foreach (QString name, QSqlDatabase::drivers()) qDebug() << name;

    QSqlQuery query;
    query.prepare("SELECT count(*) FROM stations");
    //query.bindValue(":tablename", table); bind is OK for FROM clause ????

    if (query.exec())
    {
        if (query.next())
        {
            uint nbrec = query.value(0).toUInt();
            qDebug() << "Found" << nbrec << "stations";
        }
    }
#endif

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

     stationView = new QTableView;
     stationView->verticalHeader()->setVisible(false);
     stationView->horizontalHeader()->setSortIndicatorShown(true);
     stationView->setModel(stationModel);

     stationView->setSelectionBehavior(QAbstractItemView::SelectRows);
     stationView->setSelectionMode(QAbstractItemView::SingleSelection);
     stationView->setEditTriggers(QAbstractItemView::NoEditTriggers);

     hHeaderView = stationView->horizontalHeader();
     connect(hHeaderView, SIGNAL(sectionClicked(int)), this, SLOT(on_sectionClicked(int)));

     stationView->sortByColumn(3,Qt::AscendingOrder);
     stationView->resizeColumnsToContents();
     //stationView->resizeRowsToContents();  // Why is it not as simple as this ?
     stationView->verticalHeader()->setSectionResizeMode(QHeaderView::ResizeToContents);

     QVBoxLayout *MainLayout = new QVBoxLayout;
     MainLayout->addWidget(stationView);
 
     QWidget *centerZone = new QWidget;
     centerZone->setLayout(MainLayout);
     setCentralWidget(centerZone);
}
