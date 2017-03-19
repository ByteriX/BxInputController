/**
 *	@file BxInputChildSelectorSuggestionCell.swift
 *	@namespace BxInputController
 *
 *	@details Cell for suggestion rows which used in BxInputSelectorSuggestionsRow. Usaully this class overrided in Projects
 *	@date 13.01.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import UIKit

/// Cell for suggestion rows which used in BxInputSelectorSuggestionsRow. Usaully this class overrided in Projects
open class BxInputChildSelectorSuggestionCell: UITableViewCell {
    
    // title of item
    @IBOutlet weak open var titleLabel: UILabel!
    
}
