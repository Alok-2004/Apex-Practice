/*
We will get External Ids


for One External ID
Get all the Account for that External ID in LAstModified Desc ORder

and start 

Checks

1. Not(Acc Name = Do not Use and Parent Id == Null)
2. Website and Phone Number not Null


Conclusion
1. 1st is True then that is Parent Account and Stop Search
2. 1st is False but 2nd is True  (Potential PArent Account but check Others) 



and all Of these should be Bulkified
*/
public with sharing class Task_ParentAccount {
	List<Account> FinalList = new List<Account>();

	public Task_ParentAccount(List<String> externalIds) {
		List<Account> accList = [
			SELECT Id, Name, External_Id__c, ParentId, Website, Phone
			FROM Account
			WHERE External_Id__c IN :externalIds
			ORDER BY LastModifiedDate DESC
		];

		if (!accList.isEmpty()) {
			Map<String, List<Account>> accMap = new Map<String, List<Account>>();

			for (Account acc : accList) {
				if (!accMap.containsKey(acc.External_Id__c)) {
					accMap.put(acc.External_Id__c, new List<Account>());
				}
				accMap.get(acc.External_Id__c).add(acc);
			}

			for (String key : accMap.keySet()) {
				Account parentAcc = getParent(accMap.get(key));
				System.debug(
					'External ID: ' + key + ' | Parent Account Id: ' + parentAcc.Id
				);
			}

			if (!FinalList.isEmpty()) {
				update FinalList;
			}
		}
	}

	Account getParent(List<Account> accList) {
		if (accList.size() == 1) {
			return accList[0];
		}

		Account parentAcc = null;
		Boolean gotPotentialParent = false;

		for (Account acc : accList) {
			if (acc.Name != 'Do not Use' && acc.ParentId == null) {
				parentAcc = acc;
				break;
			} else if (acc.Website != null && acc.Phone != null) {
				parentAcc = acc;
				gotPotentialParent = true;
			} else if (!gotPotentialParent) {
				parentAcc = acc;
			}
		}

		for (Account acc : accList) {
			if (parentAcc == null || acc.Id == parentAcc.Id)
				continue;
			acc.ParentId = parentAcc.Id;
			FinalList.add(acc);
		}

		return parentAcc;
	}
}
