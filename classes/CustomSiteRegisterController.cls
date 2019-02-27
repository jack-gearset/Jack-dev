public with sharing class CustomSiteRegisterController {      
    private static Id PORTAL_ACCOUNT_ID = '001x000xxx35tPN';

    private Team__c team;
    
    public CustomSiteRegisterController () {
        team = new Team__c();
    }

    public Trial trial {get; set;}
    public String username {get; set;}
    public String email {get; set;}
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    public String communityNickname {get; set { communityNickname = value == null ? value : value.trim(); } }
      
    private boolean isValidPassword() {
        return password == confirmPassword;
    }

    private void setUserTeamId(String id) {
        team.OwnerId__c = id;
    }
    
    public System.PageReference registerUser() {
        if (!isValidPassword()) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
            ApexPages.addMessage(msg);
            return null;
        }
        Trial t = new Trial(0);
        User u = new User();
        u.Username = username;
        u.Email = email;
        u.CommunityNickname = communityNickname;
        
        String accountId = PORTAL_ACCOUNT_ID;

        String userId = Site.createPortalUser(u, accountId, password);
        setUserTeamId(userId);
        if (userId != null) { 
            if (password != null && password.length() > 1) {
                return Site.login(username, password, null);
            }
        }
        return null;
    }
    
    class Trial {

        private Integer trialId;

        public Trial(Integer trialId) {
            this.trialId = trialId;
        }
    
    }
}