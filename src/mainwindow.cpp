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
#include <QFile>
#include <QDebug>

void sectionClicked(QTableView *aTableView, int aIndex)
{
    if (aTableView->horizontalHeader()->sortIndicatorOrder()==Qt::AscendingOrder)
    {
        aTableView->sortByColumn(aIndex,Qt::AscendingOrder);
    }
    else
    {
        aTableView->sortByColumn(aIndex,Qt::DescendingOrder);
    }
}

MainWindow::MainWindow()
{
    setupDB();
    setupMenuBar();
    resize(640, 480);

    QTabWidget *tabWidget = new QTabWidget;
    tabWidget->addTab(new StationsTab(), tr("Stations"));
    tabWidget->addTab(new LinesTab(), tr("Lines"));

    QVBoxLayout *mainLayout = new QVBoxLayout;
    mainLayout->addWidget(tabWidget);

    QWidget *centerZone = new QWidget;
    centerZone->setLayout(mainLayout);
    setCentralWidget(centerZone);
}

void MainWindow::setupDB()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    QString dbfilename = DATADIR "/be-rail.sqlite";
    if (!QFile::exists(dbfilename))
    {
        qDebug() << dbfilename << "not found";
        return;
    }
    db.setDatabaseName(dbfilename);

    if (!db.open())
    {
        QMessageBox::critical(this, tr("Error"), tr("Connection with database %1 failed").arg(dbfilename));
        qDebug() << "Error: connection with database " << dbfilename;
        return;
    }
    else
    {
        qDebug() << "Database: connection with " << dbfilename;
    }

#ifndef NDEBUG
    QSqlQuery query;
    uint nbrec;

    query.prepare("SELECT count(*) FROM stations");
    if (query.exec())
    {
        if (query.first())
        {
            nbrec = query.value(0).toUInt();
            qDebug() << "Found" << nbrec << "stations";
        }
        query.finish();
    }
    query.prepare("SELECT count(*) FROM lines");
    if (query.exec())
    {
        if (query.first())
        {
            nbrec = query.value(0).toUInt();
            qDebug() << "Found" << nbrec << "lines";
        }
        query.finish();
    }
#endif
}

void MainWindow::setupMenuBar()
{
    QMenu *fileMenu = menuBar()->addMenu(tr("&File"));
    //fileMenu->addSeparator();
    fileMenu->addAction(tr("&Quit"), this, &MainWindow::quit);

    QMenu *helpMenu = menuBar()->addMenu(tr("&Help"));

    helpMenu->addAction(tr("About"), this, &MainWindow::about);
    //QAction *AboutAction = helpMenu->addAction(tr("About")); 
    //connect(AboutAction, SIGNAL(triggered()), this, SLOT(about()));

    helpMenu->addAction(tr("About Qt"), qApp, &QApplication::aboutQt);
    //QAction *AboutQtAction = helpMenu->addAction(tr("About Qt"));
    //connect(AboutQtAction, SIGNAL(triggered()), qApp, SLOT(aboutQt()));
}

void MainWindow::quit()
{
    close();
}

void MainWindow::about()
{
    QMessageBox::about(this, tr("About be-rail"),
            tr("<b>be-rail</b> "
               "version " STR_VERSION "<br>"));
}

void StationsTab::on_sectionClicked(int aIndex)
{
    sectionClicked(stationsView, aIndex);
}

StationsTab::StationsTab(QWidget *parent) : QWidget(parent)
{
    QString locale = QLocale::system().name().left(2);
    QSqlTableModel *stationsModel = new QSqlTableModel;
    stationsModel->setTable("stations");
    //stationsModel->setFilter("OOS = 'N'") to use with a checkbox for example
    stationsModel->select();
    stationsModel->removeColumn(0);
    if (locale == "nl")
    {
        stationsModel->removeColumn(8);
        stationsModel->removeColumn(7);
        stationsModel->removeColumn(6);
    } else
    if (locale == "fr")
    {
        stationsModel->removeColumn(8);
        stationsModel->removeColumn(7);
        stationsModel->removeColumn(5);
    } else
    if (locale == "de")
    {
        stationsModel->removeColumn(8);
        stationsModel->removeColumn(6);
        stationsModel->removeColumn(5);
    } else
    {
        stationsModel->removeColumn(7);
        stationsModel->removeColumn(6);
        stationsModel->removeColumn(5);
    }
    stationsModel->setHeaderData(0, Qt::Horizontal,tr("Line"));
    stationsModel->setHeaderData(1, Qt::Horizontal,tr("OOS"));
    stationsModel->setHeaderData(2, Qt::Horizontal,tr("Station"));
    stationsModel->setHeaderData(3, Qt::Horizontal,tr("Code"));
    stationsModel->setHeaderData(4, Qt::Horizontal,tr("Old code"));
    stationsModel->setHeaderData(5, Qt::Horizontal,tr("Note"));
    stationsView = new QTableView;
    stationsView->verticalHeader()->setVisible(false);
    stationsView->horizontalHeader()->setSortIndicatorShown(true);
    stationsView->setModel(stationsModel);

    stationsView->setSelectionBehavior(QAbstractItemView::SelectRows);
    stationsView->setSelectionMode(QAbstractItemView::SingleSelection);
    stationsView->setEditTriggers(QAbstractItemView::NoEditTriggers);

    QHeaderView *hHeaderView = stationsView->horizontalHeader();
    connect(hHeaderView, SIGNAL(sectionClicked(int)), this, SLOT(on_sectionClicked(int)));

    stationsView->sortByColumn(3,Qt::AscendingOrder);
    stationsView->resizeColumnsToContents();
    //stationView->resizeRowsToContents();  // Why is it not as simple as this ?
    stationsView->verticalHeader()->setSectionResizeMode(QHeaderView::ResizeToContents);

    QVBoxLayout *MainLayout = new QVBoxLayout;
    MainLayout->addWidget(stationsView);
    setLayout(MainLayout);
}

void LinesTab::on_sectionClicked(int aIndex)
{
    sectionClicked(linesView, aIndex);
}

LinesTab::LinesTab(QWidget *parent) : QWidget(parent)
{
    QString locale = QLocale::system().name().left(2);
    QSqlTableModel *linesModel = new QSqlTableModel;
    linesModel->setTable("lines");
    linesModel->select();
    if (locale == "nl")
    {
        linesModel->removeColumn(4);
        linesModel->removeColumn(3);
        linesModel->removeColumn(2);
    } else
    if (locale == "fr")
    {
        linesModel->removeColumn(4);
        linesModel->removeColumn(3);
        linesModel->removeColumn(1);
    } else
    if (locale == "de")
    {
        linesModel->removeColumn(4);
        linesModel->removeColumn(2);
        linesModel->removeColumn(1);
    } else
    {
        linesModel->removeColumn(3);
        linesModel->removeColumn(2);
        linesModel->removeColumn(1);
    }
    linesModel->setHeaderData(0, Qt::Horizontal,tr("Number"));
    linesModel->setHeaderData(1, Qt::Horizontal,tr("Name"));
    linesView = new QTableView;
    linesView->verticalHeader()->setVisible(false);
    linesView->horizontalHeader()->setSortIndicatorShown(true);
    linesView->setModel(linesModel);

    linesView->setSelectionBehavior(QAbstractItemView::SelectRows);
    linesView->setSelectionMode(QAbstractItemView::SingleSelection);
    linesView->setEditTriggers(QAbstractItemView::NoEditTriggers);

    QHeaderView *hHeaderView = linesView->horizontalHeader();
    connect(hHeaderView, SIGNAL(sectionClicked(int)), this, SLOT(on_sectionClicked(int)));

    //stationsView->sortByColumn(0,Qt::AscendingOrder);
    linesView->resizeColumnsToContents();
    linesView->resizeRowsToContents();  // Why does this not work for stations view ?

    QVBoxLayout *MainLayout = new QVBoxLayout;
    MainLayout->addWidget(linesView);
    setLayout(MainLayout);
}
