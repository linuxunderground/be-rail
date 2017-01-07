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


#include <QApplication>

#include "mainwindow.h"
 

int main(int argc, char *argv[])
{
    QApplication::setApplicationName("be-rail");
    QApplication::setApplicationVersion(STR_VERSION);
    QApplication::setOrganizationDomain("linuxunderground.be");
#if QT_VERSION >= QT_VERSION_CHECK(5, 7, 0)
    QApplication::setDesktopFileName(QLatin1String("be-rail.desktop"));
#endif

    QApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/be-rail.png"));
    MainWindow window;
    window.show();

    return app.exec();
} 
