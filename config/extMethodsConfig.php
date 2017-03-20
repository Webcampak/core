<?php
/*
Copyright 2010-2015 Eurotechnia (support@webcampak.com)
This file is part of the Webcampak project.
Webcampak is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License,
or (at your option) any later version.

Webcampak is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with Webcampak.
If not, see http://www.gnu.org/licenses/.
*/

/*
 *
 *  The application index control which application is allowed to use the method
 *
 *  array('UserSettings'=>array('applications'=>array('all'), 'folder'=>'Test', 'methods'=>array('getSettings'=>array('len'=>1, 'applications'=>array('all'))))
 *  => Anyone will be allowed to access getSettings
 *
 *  array('UserSettings'=>array('applications'=>array('all'), 'folder'=>'Test', 'methods'=>array('getSettings'=>array('len'=>1, 'applications'=>array('APP_ABCD'))))
 *  => Anyone will be able to access getSettings since at controller level applications is set to all
 *
 *  array('UserSettings'=>array('applications'=>array('APP_ABCD', 'APP_BCDE'), 'folder'=>'Test', 'methods'=>array('getSettings'=>array('len'=>1, 'applications'=>array('all'))))
 *  => Only a user with APP_ABCD or APP_BCDE will be able to access getSettings
 *
 *  array('UserSettings'=>array('applications'=>array('APP_ABCD', 'APP_BCDE'), 'folder'=>'Test', 'methods'=>array('getSettings'=>array('len'=>1, 'applications'=>array('APP_ABCD'))))
 *  => Only a user with APP_ABCD will be able to access getSettings
 *
 */

$extMethodsConfig = array(
   'UserSettings'=>array(
      'applications'=>array('all')
      , 'folder'=>'Authentication'
      , 'methods'=>array(
         'getSettings'=>array('len'=>1, 'applications'=>array('all')) // 2016-02-14: Returns various user settings and flags
      )
   )

   , 'DesktopStatefulConfiguration'=>array(
        'applications'=>array('all')
      , 'folder'=>'Authentication'
      , 'methods'=>array(
            'getStatefulConfiguration'          =>array('len'=>1, 'applications'=>array('all')) // 2016-02-14: Used at startup to obtain desktop configuration for a specific user
            , 'addUpdateStatefulConfiguration'  =>array('len'=>1, 'applications'=>array('all'))
            , 'removeStatefulConfiguration'     =>array('len'=>1, 'applications'=>array('all'))
         )
   )

   , 'DesktopEmails'=>array(
        'applications'=>array('WEB_DSP_PICTURES')
      , 'folder'=>'Desktop'
      , 'methods'=>array(
            'getEmails'     =>array('len'=>1, 'applications'=>array('all'))
            , 'sendEmail'   =>array('len'=>1, 'applications'=>array('all'))
            , 'removeEmail' =>array('len'=>1, 'applications'=>array('all'))
         )
   )

   , 'Administrative'=>array(
      'applications'=>array('all')
      , 'folder'=>'Desktop'
      , 'methods'=>array(
         'emptyAnswer'                  =>array('len'=>1, 'applications'=>array('all'))
         , 'getTimezones'               =>array('len'=>1, 'applications'=>array('all'))
         , 'getUsbPorts'                =>array('len'=>1, 'applications'=>array('all'))
         , 'getCameraModels'            =>array('len'=>1, 'applications'=>array('all'))
         , 'getPhidgetsPorts'           =>array('len'=>1, 'applications'=>array('all'))
         , 'getWatermarkFiles'          =>array('len'=>1, 'applications'=>array('all'))
      )
   )

   , 'Applications'=>array(
      'applications'=>array('all')
      , 'folder'=>'Desktop'
      , 'methods'=>array(
         'getApplications'              =>array('len'=>1, 'applications'=>array('all')) // 2016-02-14: Used at startup to obtain list of all available applications
         , 'getCurrentApplications'     =>array('len'=>1, 'applications'=>array('all')) // 2016-02-14: Used at startup to obtain the list of applications available (access granted) for the logged-in user
      )
   )

   , 'DesktopIcons'=>array(
      'applications'=>array('all')
      , 'folder'=>'Desktop'
      , 'methods'=>array(
         'getDesktopAvailableIcons'       =>array('len'=>1, 'applications'=>array('all'))
         , 'addDesktopAvailableIcons'     =>array('len'=>1, 'applications'=>array('all'))
         , 'removeDesktopAvailableIcons'  =>array('len'=>1, 'applications'=>array('all'))
         , 'updateDesktopAvailableIcons'  =>array('len'=>1, 'applications'=>array('all'))
         , 'getDesktopCurrentIcons'       =>array('len'=>1, 'applications'=>array('all'))   // 2016-02-14: Used at startup to obtain the list of icons to be displayed for a user
         , 'addDesktopCurrentIcons'       =>array('len'=>1, 'applications'=>array('all'))
         , 'removeDesktopCurrentIcons'    =>array('len'=>1, 'applications'=>array('all'))
         , 'updateDesktopCurrentIcons'    =>array('len'=>1, 'applications'=>array('all'))
      )
   )

   , 'Sources'=>array(
      'applications'=>array('all')
      , 'folder'=>'Desktop'
      , 'methods'=>array(
         'getSources'          =>array('len'=>1, 'applications'=>array('all'))
      )
   )
    
   , 'SyncReports'=>array(
      'applications'=>array('WEB_DSP_SYNCREPORTS')
      , 'folder'=>'Desktop/SyncReports'
      , 'methods'=>array(
         'getSyncReports'       =>array('len'=>1, 'applications'=>array('all'))
         , 'createSyncReport'      =>array('len'=>1, 'applications'=>array('all'))
         , 'removeSyncReport'   =>array('len'=>1, 'applications'=>array('all'))
      )
   )    
   , 'XferReports'=>array(
      'applications'=>array('WEB_DSP_XFERREPORTS')
      , 'folder'=>'Desktop/XferReports'
      , 'methods'=>array(
         'getXferReports'       =>array('len'=>1, 'applications'=>array('all'))
      )
   )     

   , 'Pictures'=>array(
      'applications'=>array('WEB_DSP_PICTURES') // 2016-02-14
      , 'folder'=>'Desktop/Pictures'
      , 'methods'=>array(
         'getHoursList'          =>array('len'=>1, 'applications'=>array('all'))
         , 'getDaysList'         =>array('len'=>1, 'applications'=>array('all'))
         , 'getPicture'          =>array('len'=>1, 'applications'=>array('all'))
         , 'getSensors'          =>array('len'=>1, 'applications'=>array('all'))
      )
   )

   , 'Videos'=>array(
      'applications'=>array('WEB_DSP_VIDEOS') // 2016-02-14
      , 'folder'=>'Desktop/Videos'
      , 'methods'=>array(
         'getDaysList'          =>array('len'=>1, 'applications'=>array('all'))
         , 'getVideosList'      =>array('len'=>1, 'applications'=>array('all'))
      )
   )

   , 'Stats'=>array(
      'applications'=>array('all')
      , 'folder'=>'Desktop/Stats'
      , 'methods'=>array(
         'getSystemStats'               =>array('len'=>1, 'applications'=>array('WEB_DSP_STATS_SYSTEM')) // 2016-02-14
         , 'getSourcesPicturesCountSize'=>array('len'=>1, 'applications'=>array('WEB_DSP_STATS_SOURCES')) // 2016-02-14
         , 'getSourcesDiskUsage'        =>array('len'=>1, 'applications'=>array('WEB_DSP_STATS_SOURCES')) // 2016-02-14
      )
   )

   , 'Logs'=>array(
      'applications'=>array('WEB_DSP_LOGS') // 2016-02-14
      , 'folder'=>'Desktop/Logs'
      , 'methods'=>array(
         'getCaptureLogs'           =>array('len'=>1, 'applications'=>array('all'))
         , 'getConfigurationLogs'   =>array('len'=>1, 'applications'=>array('all'))
         , 'getCustomVideosLogs'    =>array('len'=>1, 'applications'=>array('all'))
         , 'getPostprodLogs'        =>array('len'=>1, 'applications'=>array('all'))
         , 'getVideosLogs'          =>array('len'=>1, 'applications'=>array('all'))
      )
   )

   , 'Devices'=>array(
      'applications'=>array('all')
      , 'folder'=>'Desktop/Devices'
      , 'methods'=>array(
         'getDevices'           =>array('len'=>1, 'applications'=>array('all'))
      )
   )

   , 'SystemConfiguration'=>array(
      'applications'=>array('WEB_CFG_SYSTEM') // 2016-02-14
      , 'folder'=>'Desktop/Systemconfiguration'
      , 'methods'=>array(
         'getConfiguration'           =>array('len'=>1, 'applications'=>array('all'))
         , 'updateConfiguration'      =>array('len'=>1, 'applications'=>array('all'))

      )
   )

   , 'SCCapture'=>array(
      'applications'=>array('WEB_CFG_SOURCES')
      , 'folder'=>'Desktop/Sourcesconfiguration'
      , 'methods'=>array(
         'getCapture'           =>array('len'=>1, 'applications'=>array('all'))
         , 'updateCapture'      =>array('len'=>1, 'applications'=>array('all'))
         , 'getSectionCapture'  =>array('len'=>1, 'applications'=>array('all'))

      )
   )
   , 'SCFTPServers'=>array(
      'applications'=>array('WEB_CFG_SOURCES')
      , 'folder'=>'Desktop/Sourcesconfiguration'
      , 'methods'=>array(
         'getFTPServers'      =>array('len'=>1, 'applications'=>array('all'))
         , 'addFTPServer'       =>array('len'=>1, 'applications'=>array('all'))
         , 'removeFTPServer'    =>array('len'=>1, 'applications'=>array('all'))
         , 'updateFTPServer'    =>array('len'=>1, 'applications'=>array('all'))
      )
   )
   , 'SCVideo'=>array(
      'applications'=>array('WEB_CFG_SOURCES')
      , 'folder'=>'Desktop/Sourcesconfiguration'
      , 'methods'=>array(
         'getVideo'           =>array('len'=>1, 'applications'=>array('all'))
         , 'updateVideo'        =>array('len'=>1, 'applications'=>array('all'))
         , 'getSectionVideo'         =>array('len'=>1, 'applications'=>array('all'))
      )
   )
   , 'SCVideoCustom'=>array(
      'applications'=>array('WEB_CFG_SOURCES')
      , 'folder'=>'Desktop/Sourcesconfiguration'
      , 'methods'=>array(
         'getVideoCustom'     =>array('len'=>1, 'applications'=>array('all'))
         , 'updateVideoCustom'  =>array('len'=>1, 'applications'=>array('all'))
         , 'getSectionVideoCustom'   =>array('len'=>1, 'applications'=>array('all'))
      )
   )
   , 'SCVideoPost'=>array(
      'applications'=>array('WEB_CFG_SOURCES')
      , 'folder'=>'Desktop/Sourcesconfiguration'
      , 'methods'=>array(
         'getVideoPost'       =>array('len'=>1, 'applications'=>array('all'))
         , 'updateVideoPost'    =>array('len'=>1, 'applications'=>array('all'))
         , 'getSectionVideoPost'     =>array('len'=>1, 'applications'=>array('all'))

      )
   )

   , 'SCWindow'=>array(
      'applications'=>array('WEB_CFG_SOURCES')
      , 'folder'=>'Desktop/Sourcesconfiguration'
      , 'methods'=>array(
         'getConfigurationTabs'    =>array('len'=>1, 'applications'=>array('all'))
      )
   )

   , 'SCMisc'=>array(
      'applications'=>array('WEB_CFG_SOURCES')
      , 'folder'=>'Desktop/Sourcesconfiguration'
      , 'methods'=>array(
         'getWatermarkFiles'    =>array('len'=>1, 'applications'=>array('all'))
         , 'getAudioFiles'      =>array('len'=>1, 'applications'=>array('all'))
         , 'getFonts'           =>array('len'=>1, 'applications'=>array('all'))
         , 'getPhidgetSensors'  =>array('len'=>1, 'applications'=>array('all'))
         , 'getCaptureSchedule' =>array('len'=>1, 'applications'=>array('all'))
         , 'saveCaptureSchedule'=>array('len'=>1, 'applications'=>array('all'))
      )
   )

   , 'ACGroups'=>array(
      'applications'=>array('WEB_CFG_ACCESSCONTROL') // 2016-02-14: Used to manage groups through access control app
      , 'folder'=>'Desktop/Accesscontrol'
      , 'methods'=>array(
          'getGroups'                        =>array('len'=>1, 'applications'=>array('all'))
          , 'addGroup'                       =>array('len'=>1, 'applications'=>array('all'))
          , 'removeGroup'                    =>array('len'=>1, 'applications'=>array('all'))
          , 'updateGroup'                    =>array('len'=>1, 'applications'=>array('all'))

          , 'getGroupAvailablePermissions'   =>array('len'=>1, 'applications'=>array('all'))
          , 'addGroupAvailablePermissions'   =>array('len'=>1, 'applications'=>array('all'))
          , 'removeGroupAvailablePermissions'=>array('len'=>1, 'applications'=>array('all'))
          , 'updateGroupAvailablePermissions'=>array('len'=>1, 'applications'=>array('all'))

          , 'getGroupCurrentPermissions'     =>array('len'=>1, 'applications'=>array('all'))
          , 'addGroupCurrentPermissions'     =>array('len'=>1, 'applications'=>array('all'))
          , 'removeGroupCurrentPermissions'  =>array('len'=>1, 'applications'=>array('all'))
          , 'updateGroupCurrentPermissions'  =>array('len'=>1, 'applications'=>array('all'))

          , 'getGroupAvailableApplications'  =>array('len'=>1, 'applications'=>array('all'))
          , 'addGroupAvailableApplications'  =>array('len'=>1, 'applications'=>array('all'))
          , 'removeGroupAvailableApplications'=>array('len'=>1, 'applications'=>array('all'))
          , 'updateGroupAvailableApplications'=>array('len'=>1, 'applications'=>array('all'))

          , 'getGroupCurrentApplications'    =>array('len'=>1, 'applications'=>array('all'))
          , 'addGroupCurrentApplications'    =>array('len'=>1, 'applications'=>array('all'))
          , 'removeGroupCurrentApplications' =>array('len'=>1, 'applications'=>array('all'))
          , 'updateGroupCurrentApplications' =>array('len'=>1, 'applications'=>array('all'))
      )
   )

   , 'ACCustomers'=>array(
      'applications'=>array('WEB_CFG_ACCESSCONTROL') // 2016-02-14: Used to manage customers through access control app
      , 'folder'=>'Desktop/Accesscontrol'
      , 'methods'=>array(
          'getCustomers'                        =>array('len'=>1, 'applications'=>array('all'))
          , 'addCustomer'                       =>array('len'=>1, 'applications'=>array('all'))
          , 'removeCustomer'                    =>array('len'=>1, 'applications'=>array('all'))
          , 'updateCustomer'                    =>array('len'=>1, 'applications'=>array('all'))
      )
   )
   , 'ACUsers'=>array(
      'applications'=>array('WEB_CFG_ACCESSCONTROL') // 2016-02-14: Used to manage users through access control app
      , 'folder'=>'Desktop/Accesscontrol'
      , 'methods'=>array(
          'getUsers'                      =>array('len'=>1, 'applications'=>array('all'))
          , 'addUser'                     =>array('len'=>1, 'applications'=>array('all'))
          , 'removeUser'                  =>array('len'=>1, 'applications'=>array('all'))
          , 'updateUser'                  =>array('len'=>1, 'applications'=>array('all'))

          , 'getUserAvailableSources'      =>array('len'=>1, 'applications'=>array('all'))
          , 'addUserAvailableSources'      =>array('len'=>1, 'applications'=>array('all'))
          , 'removeUserAvailableSources'   =>array('len'=>1, 'applications'=>array('all'))
          , 'updateUserAvailableSources'   =>array('len'=>1, 'applications'=>array('all'))

          , 'getUserCurrentSources'        =>array('len'=>1, 'applications'=>array('all'))
          , 'addUserCurrentSources'        =>array('len'=>1, 'applications'=>array('all'))
          , 'removeUserCurrentSources'     =>array('len'=>1, 'applications'=>array('all'))
          , 'updateUserCurrentSources'     =>array('len'=>1, 'applications'=>array('all'))

          , 'getUserAvailablePermissions'    =>array('len'=>1, 'applications'=>array('all'))
          , 'addUserAvailablePermissions'    =>array('len'=>1, 'applications'=>array('all'))
          , 'removeUserAvailablePermissions' =>array('len'=>1, 'applications'=>array('all'))
          , 'updateUserAvailablePermissions' =>array('len'=>1, 'applications'=>array('all'))

          , 'getUserCurrentPermissions'     =>array('len'=>1, 'applications'=>array('all'))
          , 'addUserCurrentPermissions'     =>array('len'=>1, 'applications'=>array('all'))
          , 'removeUserCurrentPermissions'  =>array('len'=>1, 'applications'=>array('all'))
          , 'updateUserCurrentPermissions'  =>array('len'=>1, 'applications'=>array('all'))

          , 'getUserAvailableApplications'   =>array('len'=>1, 'applications'=>array('all'))
          , 'addUserAvailableApplications'   =>array('len'=>1, 'applications'=>array('all'))
          , 'removeUserAvailableApplications'=>array('len'=>1, 'applications'=>array('all'))
          , 'updateUserAvailableApplications'=>array('len'=>1, 'applications'=>array('all'))

          , 'getUserCurrentApplications'     =>array('len'=>1, 'applications'=>array('all'))
          , 'addUserCurrentApplications'     =>array('len'=>1, 'applications'=>array('all'))
          , 'removeUserCurrentApplications'  =>array('len'=>1, 'applications'=>array('all'))
          , 'updateUserCurrentApplications'  =>array('len'=>1, 'applications'=>array('all'))

          , 'changePassword'                 =>array('len'=>1, 'applications'=>array('all'))
      )
   )

   , 'ACSources'=>array(
      'applications'=>array('WEB_CFG_ACCESSCONTROL') // 2016-02-14: Used to manage users through access control app
      , 'folder'=>'Desktop/Accesscontrol'
      , 'methods'=>array(
          'getSources'                        =>array('len'=>1, 'applications'=>array('all'))
          , 'addSource'                       =>array('len'=>1, 'applications'=>array('all'))
          , 'removeSource'                    =>array('len'=>1, 'applications'=>array('all'))
          , 'updateSource'                    =>array('len'=>1, 'applications'=>array('all'))

          , 'getSourceAvailableUsers'         =>array('len'=>1, 'applications'=>array('all'))
          , 'addSourceAvailableUsers'         =>array('len'=>1, 'applications'=>array('all'))
          , 'removeSourceAvailableUsers'      =>array('len'=>1, 'applications'=>array('all'))
          , 'updateSourceAvailableUsers'      =>array('len'=>1, 'applications'=>array('all'))

          , 'getSourceCurrentUsers'             =>array('len'=>1, 'applications'=>array('all'))
          , 'addSourceCurrentUsers'             =>array('len'=>1, 'applications'=>array('all'))
          , 'removeSourceCurrentUsers'          =>array('len'=>1, 'applications'=>array('all'))
          , 'updateSourceCurrentUsers'          =>array('len'=>1, 'applications'=>array('all'))
      )
   )

);

$container->setParameter('extMethodsConfig', $extMethodsConfig);

?>
