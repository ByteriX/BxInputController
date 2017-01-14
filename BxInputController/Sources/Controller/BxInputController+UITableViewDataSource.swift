//
//  BxInputController+UITableViewDataSource.swift
//  BxInputController
//
//  Created by Sergey Balalaev on 14/01/17.
//  Copyright © 2017 Byterix. All rights reserved.
//

import UIKit

extension BxInputController : UITableViewDataSource
{

    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sections[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let row = getRow(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.resourceId, for: indexPath) as! BxInputStandartCell
        cell.parent = self
        cell.update(data: row)
        return cell
    }

}
