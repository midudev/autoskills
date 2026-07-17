---
name: qt
description: "Build cross-platform C++ and QML applications with Qt. Use when creating GUI apps with Widgets or Qt Quick, working with signals/slots, model/view architecture, networking, database access, multimedia, threading, or building with CMake/qmake. Covers Qt 6.x."
metadata:
  version: "1.0"
  source: "autoskills"
---

# Qt Framework

## When to Use

- Creating cross-platform GUI applications (Desktop, Mobile, Embedded)
- Working with signals & slots communication pattern
- Building UIs with Widgets (classic) or Qt Quick/QML (declarative)
- Model/View architecture with `QAbstractItemModel`
- Networking (HTTP, TCP/UDP, WebSocket)
- Database access with `QSqlDatabase`
- Multimedia (audio, video, camera)
- Threading with `QThread` or `QtConcurrent`
- Building with CMake (preferred) or qmake (legacy)
- Exposing C++ objects to QML via `Q_PROPERTY` or context properties

## Build System: CMake (Qt 6)

Qt 6 recommends CMake. Minimum `CMakeLists.txt`:

```cmake
cmake_minimum_required(VERSION 3.16)
project(MyApp VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Widgets)

qt_add_executable(MyApp
    main.cpp
    mainwindow.cpp
    mainwindow.h
)

target_link_libraries(MyApp PRIVATE Qt6::Core Qt6::Widgets)
```

Build:
```bash
cmake -B build -DCMAKE_PREFIX_PATH=/path/to/qt6
cmake --build build
```

For QML-only apps:
```cmake
qt_add_executable(MyApp main.cpp)
qt_add_qml_module(MyApp
    URI MyApp
    VERSION 1.0
    QML_FILES Main.qml
)
```

## Signals & Slots

### C++ Declaration

```cpp
class MyClass : public QObject {
    Q_OBJECT
public:
    explicit MyClass(QObject *parent = nullptr);

signals:
    void dataReady(const QString &data);
    void errorOccurred(int code, const QString &msg);

public slots:
    void processData(const QString &input);
    void reset();
};

// Connection
MyClass source, target;
QObject::connect(&source, &MyClass::dataReady, &target, &MyClass::processData);

// Lambda
QObject::connect(&source, &MyClass::errorOccurred,
    [](int code, const QString &msg) {
        qWarning() << "Error" << code << ":" << msg;
    });
```

### QML Connections

```qml
import QtQuick

Rectangle {
    id: root
    color: "white"
    width: 300; height: 200

    Text {
        id: label
        text: "Waiting..."
    }

    MouseArea {
        anchors.fill: parent
        onClicked: console.log("Clicked at", mouse.x, mouse.y)
    }

    ListModel {
        id: listModel
    }

    Connections {
        target: backend
        function onDataReady(data) { label.text = data }
    }
}
```

## QML Basics

```qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("My App")

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16

        TextField {
            id: input
            placeholderText: qsTr("Enter text...")
            Layout.fillWidth: true
        }

        Button {
            text: qsTr("Submit")
            enabled: input.text.length > 0
            onClicked: backend.submit(input.text)
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: listModel
            delegate: Label {
                required property string display
                text: display
                padding: 8
            }
        }
    }
}
```

## Model/View (C++)

```cpp
class StringListModel : public QAbstractListModel {
    Q_OBJECT
public:
    enum Roles { NameRole = Qt::UserRole + 1 };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override {
        return m_data.size();
    }

    QVariant data(const QModelIndex &index, int role) const override {
        if (!index.isValid()) return {};
        if (role == NameRole || role == Qt::DisplayRole)
            return m_data.at(index.row());
        return {};
    }

    QHash<int, QByteArray> roleNames() const override {
        return { { NameRole, "name" } };
    }

    void appendString(const QString &str) {
        beginInsertRows(QModelIndex(), m_data.size(), m_data.size());
        m_data.append(str);
        endInsertRows();
    }

private:
    QStringList m_data;
};
```

## Threading

```cpp
// Worker object pattern (preferred over subclassing QThread)
class Worker : public QObject {
    Q_OBJECT
public slots:
    void doWork(const QString &param) {
        QString result = /* ... */;
        emit resultReady(result);
    }
signals:
    void resultReady(const QString &result);
};

// Usage
QThread *thread = new QThread;
Worker *worker = new Worker;
worker->moveToThread(thread);
connect(thread, &QThread::started, worker, [=]() { worker->doWork("data"); });
connect(thread, &QThread::finished, worker, &QObject::deleteLater);
connect(worker, &Worker::resultReady, this, &MainWindow::handleResult);
connect(worker, &Worker::resultReady, thread, &QThread::quit);
connect(thread, &QThread::finished, thread, &QObject::deleteLater);
thread->start();
```

## Exposing C++ to QML

```cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "backend.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Backend backend;
    engine.rootContext()->setContextProperty("backend", &backend);

    engine.load(QUrl(QStringLiteral("qrc:/Main.qml")));
    return app.exec();
}
```

### Q_PROPERTY

```cpp
class Person : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
public:
    QString name() const { return m_name; }
    void setName(const QString &name) {
        if (m_name != name) {
            m_name = name;
            emit nameChanged();
        }
    }
signals:
    void nameChanged();
private:
    QString m_name;
};
```

## Best Practices

- Use **CMake** for Qt 6 projects (qmake is legacy)
- Always use `Q_OBJECT` macro in classes that define signals/slots
- Use **qmlformat** and **clang-format** for code style
- Prefer `moveToThread()` pattern over subclassing QThread
- Use `QPointer` for weak references to QObjects
- Use `QScopedPointer` for automatic cleanup
- Set `CMAKE_AUTOMOC ON` to handle MOC automatically
- Use `qsTr()` in QML for translatable strings
- Prefer `Connections` type in QML over `connect()` in JS
- Use `Q_PROPERTY` for exposing C++ data to QML
- Bundle resources with `qt_add_resources()` or `.qrc` files
- Use `QSettings` for persistent app configuration
- Handle `QNetworkReply::errorOccurred` for robust networking
- Use `QQuickStyle` to set the Qt Quick Controls style

## Debugging & Tools

- **Qt Creator** — IDE with debugger, profiler, visual editor
- **QML Debugger** — Attach to running QML apps for live editing
- **Qt Designer** — Visual UI designer for Widgets
- **`qDebug()`** — Primary debug output stream
- **`QT_LOGGING_RULES`** — Control debug output categories
- **Valgrind / LeakSanitizer** — Memory leak detection
- **Qt Quick Compiler** — Pre-compile QML for performance

## Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| `moc` not found | Enable `CMAKE_AUTOMOC ON` |
| QML module not found | Ensure `qt_add_qml_module` URI matches `import` in QML |
| Signals not connecting | Verify `Q_OBJECT` macro is in class declaration |
| `Q_PROPERTY` not working in QML | Ensure getter, setter, and signal all exist |
| Thread affinity issues | Use `moveToThread()`, never access GUI from worker thread |
| Resource embedding fails | Check `.qrc` file paths are relative to its location |
| Deployment missing plugins | Use `windeployqt`, `macdeployqt`, or `linuxdeployqt` |
