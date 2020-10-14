package freevana.util
{
    import flash.net.SharedObject;
    import flash.system.Capabilities;
    import freevana.view.VideoPlayer;

    /*
    * @author tirino
    */
    public class Settings
    {
        private static var SHARED_OBJECT_NAME:String = "Settings";
        private static var SETUP_COMPLETED_KEY:String = "setup_completed";
        private static var PREFERRED_LANG_KEY:String = "preferred_lang";
        private static var PREFERRED_PLAYER_KEY:String = "preferred_player";
        private static var SUBTITLES_SIZE_KEY:String = "subtitles_size";
        private static var SUBTITLES_DIR_KEY:String = "subtitles_dir";
        private static var LAST_UPDATE_CHECK:String = "last_update_check";
        private static var LAST_UPDATE_SHOWN:String = "last_update_shown";
        private static var LAST_DB_UPDATE_SHOWN:String = "last_db_update_shown";

        private var sharedObj:SharedObject;

        public function Settings():void
        {
            sharedObj = SharedObject.getLocal(SHARED_OBJECT_NAME);
        }

        /**
        * Tell if the user has enough data to use Freevana Player
        */
        public function isSetupCompleted():Boolean
        {
            var res:Object = this.getValue(SETUP_COMPLETED_KEY);
            return (res && res === true);
        }

        /**
        * Save a flag to know this user has enough data to use Freevana Player
        */
        public function markSetupCompleted():void
        {
            this.setValue(SETUP_COMPLETED_KEY, true);
        }

        /**
        * Return the preferred language set by the user, or the default one
        * according to their system settings
        */
        public function getPreferredLanguage():String
        {
            var res:String = String(this.getValue(PREFERRED_LANG_KEY));
            if (!res || res == 'null') {
                var langs:Array = Capabilities.languages;
                res = (langs[0] as String).toUpperCase();
            }
            return res;
        }

        /**
        * Save the preferred language for the user
        */
        public function setPreferredLanguage(lang:String):void
        {
            this.setValue(PREFERRED_LANG_KEY, lang.toUpperCase());
        }

        /**
        * Return the preferred player set by the user, or the default one
        */
        public function getPreferredPlayer():String
        {
            var res:String = String(this.getValue(PREFERRED_PLAYER_KEY));
            if (!res || res == 'null') {
                res = VideoPlayer.VIDEO_PLAYER_OWN;
            }
            return res;
        }

        /**
        * Save the preferred player for the user
        */
        public function setPreferredPlayer(player:String):void
        {
            this.setValue(PREFERRED_PLAYER_KEY, player.toUpperCase());
        }
        /**
        * Return the select subtitles size
        */
        public function getSubtitlesSize():String
        {
            var res:String = String(this.getValue(SUBTITLES_SIZE_KEY));
            if (!res || res == 'null') {
                res = VideoPlayer.SUBTITLES_NORMAL;
            }
            return res;
        }

        /**
        * Save the selected subtitles size
        */
        public function setSubtitlesSize(subsSize:String):void
        {
            this.setValue(SUBTITLES_SIZE_KEY, subsSize.toUpperCase());
        }

        /**
        * Return when we last checked for updates
        */
        public function getLastUpdateCheck():Number
        {
            var res:int = int(this.getValue(LAST_UPDATE_CHECK));
            if (!res) {
                res = 0;
            }
            return res;
        }

        /**
        * Set when we last checked for updates
        */
        public function setLastUpdateCheck(updateCheck:Number):void
        {
            this.setValue(LAST_UPDATE_CHECK, updateCheck);
        }

        /**
        * Return the last update number that was shown to the user
        */
        public function getLastUpdateShown():String
        {
            var res:String = String(this.getValue(LAST_UPDATE_SHOWN));
            if (!res || res == 'null') {
                res = '';
            }
            return res;
        }

        /**
        * Set the update number that was last shown to the user
        */
        public function setLastUpdateShown(updateVersion:String):void
        {
            this.setValue(LAST_UPDATE_SHOWN, updateVersion);
        }

        /**
        * Return the last update number that was shown to the user
        */
        public function getLastDBUpdateShown():String
        {
            var res:String = String(this.getValue(LAST_DB_UPDATE_SHOWN));
            if (!res || res == 'null') {
                res = '';
            }
            return res;
        }

        /**
        * Set the update number that was last shown to the user
        */
        public function setLastDBUpdateShown(updateVersion:String):void
        {
            this.setValue(LAST_DB_UPDATE_SHOWN, updateVersion);
        }

        private function setValue(key:String, val:Object):void
        {
            sharedObj.setProperty(key, val);
            sharedObj.flush();
        }

        private function getValue(key:String):Object
        {
            var res:Object = null;
            if (sharedObj.size > 0 && typeof sharedObj.data[key] != "undefined")
            {
                res = sharedObj.data[key];
            }
            return res;
        }
    }
}