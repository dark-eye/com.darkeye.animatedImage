import QtQuick 2.11
import QtQuick.Window 2.11
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kitemmodels as KItemModels

import org.kde.taskmanager 0.1 as TaskManager

Item {
	property bool noWindowActive: true
	property bool currentWindowMaximized: false
	property bool isActiveWindowPinned: false

	TaskManager.VirtualDesktopInfo { id: virtualDesktopInfo }
	TaskManager.ActivityInfo { id: activityInfo }
	TaskManager.TasksModel {
		id: tasksModel
		sortMode: TaskManager.TasksModel.SortVirtualDesktop
		groupMode: TaskManager.TasksModel.GroupDisabled

		activity: activityInfo.currentActivity
		virtualDesktop: virtualDesktopInfo.currentDesktop

		filterByActivity: true
		filterByVirtualDesktop: true
		filterByScreen: true

		onActiveTaskChanged: {
			updateActiveWindowInfo()
		}
		onDataChanged: {
			updateActiveWindowInfo()
		}
		Component.onCompleted: {
			activeWindowModel.sourceModel = tasksModel
		}
	}
	KItemModels.KSortFilterProxyModel {
		id: activeWindowModel
		filterRole: 1
		filterString: 'true'
		onDataChanged: {
			updateActiveWindowInfo()
		}
		onCountChanged: {
			updateActiveWindowInfo()
		}
	}


	function activeTask() {
		return activeWindowModel[0] || {}
	}
	
	function isOnSpecificScreen(screenId) {
        var actTask = activeTask()
        if(actTask.isOnScreen) {
            return actTask.isOnScreen(screenId);
        }
        return false;
    }

	function updateActiveWindowInfo() {
		var actTask = activeTask()
		noWindowActive = activeWindowModel.count === 0 || actTask.IsActive !== true
		currentWindowMaximized = !noWindowActive && actTask.IsMaximized === true
		isActiveWindowPinned = actTask.VirtualDesktop === -1
	}
}
